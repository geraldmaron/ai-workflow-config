#!/usr/bin/env zsh
# Shared functions for ai-workflow-config scripts. Sourced, not executed directly.

set -euo pipefail

# Location of these scripts, independent of REPO_ROOT (which is overridable so
# tests can point the content at a scratch tree while still exercising real code).
SCRIPT_DIR="$(cd "$(dirname "${(%):-%x}")" && pwd)"
REPO_ROOT="${REPO_ROOT:-$(cd "$SCRIPT_DIR/.." && pwd)}"
CORE_FILE="$REPO_ROOT/core/GLOBAL.md"
LOCAL_OVERRIDE="$REPO_ROOT/local/GLOBAL.local.md"
MANIFEST="$REPO_ROOT/manifests/managed-files.tsv"
BACKUP_DIR="$REPO_ROOT/local/backups"
SKILLS_DIR="$REPO_ROOT/skills"
SKILL_MANIFEST="$REPO_ROOT/manifests/skill-dest-roots.tsv"
OWNERSHIP_MANIFEST="$REPO_ROOT/manifests/skill-ownership.tsv"
MARK_BEGIN="<!-- ai-workflow-config:begin -->"
MARK_END="<!-- ai-workflow-config:end -->"
MANAGED_MARKER="deployed by ai-workflow-config; removed by scripts/deploy when the repo drops it, or by scripts/uninstall"
MANAGED_HEADER="<!-- MANAGED BY ai-workflow-config; edit core/GLOBAL.md, not this file; sync: ai-workflow-config/scripts/sync -->"

log()  { print -r -- "$*" >&2 }
die()  { print -r -- "error: $*" >&2; exit 1 }

# Render the content that should appear in any managed destination.
render_core() {
  local out="$MANAGED_HEADER"$'\n\n'"$(<"$CORE_FILE")"
  if [[ -f "$LOCAL_OVERRIDE" ]]; then
    out+=$'\n\n'"$(<"$LOCAL_OVERRIDE")"
  fi
  print -r -- "$out"
}

# Every script in one run shares a snapshot directory, so one rollback undoes
# the whole run. Exported so child scripts (deploy -> sync) join the same one.
export AIWF_BACKUP_TS="${AIWF_BACKUP_TS:-$(date +%Y%m%d-%H%M%S)-$$}"

# backup_path <path> - record the pre-run state of a file or directory before
# anything writes to it or removes it. The snapshot's index.tsv maps each saved
# copy to its original path, so rollback never has to guess. A path that does
# not exist yet is recorded as '-', which tells rollback to remove what the run
# created. Only the first call per path in a run counts: that is the pre-run
# state; later calls in the same run would record the run's own writes.
backup_path() {
  local target="$1"
  local dest_dir="$BACKUP_DIR/$AIWF_BACKUP_TS"
  local index="$dest_dir/index.tsv"
  mkdir -p "$dest_dir"
  if [[ -f "$index" ]] && awk -F'\t' -v p="$target" '$2==p {found=1} END {exit !found}' "$index"; then
    return 0
  fi
  if [[ ! -e "$target" ]]; then
    print -r -- "-"$'\t'"$target" >> "$index"
    return 0
  fi
  local n=1 saved
  if [[ -f "$index" ]]; then
    n=$(( $(wc -l < "$index") + 1 ))
  fi
  saved="$n-${target:t}"
  cp -Rp "$target" "$dest_dir/$saved"
  print -r -- "$saved"$'\t'"$target" >> "$index"
  log "backed up $target -> $dest_dir/$saved"
}

# Write content to a destination atomically (temp file + mv).
atomic_write() {
  local target="$1" content="$2"
  local dir
  dir=$(dirname "$target")
  mkdir -p "$dir"
  local tmp
  tmp=$(mktemp "${dir}/.aiwf.XXXXXX")
  print -r -- "$content" > "$tmp"
  mv "$tmp" "$target"
}

# Replace only the region between MARK_BEGIN/MARK_END in a file, preserving
# everything else. Creates the file with just the marked region if absent.
# Refuses a file whose markers are duplicated or unpaired: guessing which region
# is ours would either clobber hand-written text or append a second copy.
render_marked_region() {
  local target="$1" new_body="$2"
  if [[ ! -f "$target" ]]; then
    print -r -- "$MARK_BEGIN"$'\n'"$new_body"$'\n'"$MARK_END"
    return 0
  fi
  local begins ends
  begins=$(grep -cF -- "$MARK_BEGIN" "$target" || true)
  ends=$(grep -cF -- "$MARK_END" "$target" || true)
  if (( begins > 1 || ends > 1 || begins != ends )); then
    die "$target has $begins begin and $ends end markers; expected one of each. Fix the file by hand, then re-run."
  fi
  local content
  content=$(<"$target")
  if (( begins == 1 )); then
    local before after
    before="${content%%$MARK_BEGIN*}"
    after="${content#*$MARK_END}"
    print -r -- "${before}${MARK_BEGIN}"$'\n'"$new_body"$'\n'"${MARK_END}${after}"
  else
    # No existing markers: append a new managed region, preserve everything above.
    print -r -- "${content}"$'\n\n'"$MARK_BEGIN"$'\n'"$new_body"$'\n'"$MARK_END"
  fi
}

# Compute what a write in the given mode would produce.
render_for_mode() {
  local mode="$1" target="$2" core_content="$3"
  case "$mode" in
    wholesale)      print -r -- "$core_content" ;;
    marked-region)   render_marked_region "$target" "$core_content" ;;
    manual)          print -r -- "$core_content" ;;
    *) die "unknown mode: $mode" ;;
  esac
}

# Read the manifest, skipping header/comments/blank lines.
# Emits: tool<TAB>detect<TAB>destination<TAB>mode
manifest_rows() {
  tail -n +2 "$MANIFEST" | grep -v '^\s*#' | grep -v '^\s*$'
}

# Every root the skills library deploys to, gated by the same tool-detection
# expressions the core-file manifest uses (reused, not duplicated, so a tool
# detected once is detected the same way everywhere). Emits:
# label<TAB>detect<TAB>root: one row per configured destination, detected or
# not; callers filter with tool_detected.
skill_dest_rows() {
  tail -n +2 "$SKILL_MANIFEST" | grep -v '^\s*#' | grep -v '^\s*$'
}

# Detected skill destination roots only, one absolute path per line.
skill_dest_roots() {
  local label detect root
  while IFS=$'\t' read -r label detect root; do
    tool_detected "$detect" && expand_path "$root"
  done < <(skill_dest_rows)
}

# True (0) if the detect expression for a manifest row succeeds.
tool_detected() {
  local detect_expr="$1"
  eval "$detect_expr" >/dev/null 2>&1
}

# Skill concepts owned by another source. Emits: owner<TAB>skill<TAB>note
# This repo must not define a skill whose name appears here.
owned_elsewhere_rows() {
  [[ -f "$OWNERSHIP_MANIFEST" ]] || return 0
  grep -v '^\s*#' "$OWNERSHIP_MANIFEST" | grep -v '^\s*$'
}

# Repo skill directories, sorted. Emits one absolute path per line.
skill_dirs() {
  local dir
  for dir in "$SKILLS_DIR"/*/(N); do
    print -r -- "${dir%/}"
  done
}

expand_path() {
  local p="$1"
  case "$p" in
    "~/"*) print -r -- "${HOME}/${p#\~/}" ;;
    "~"*)  die "unsupported ~user path in manifest: $p" ;;
    /*)    print -r -- "$p" ;;
    *)     print -r -- "$REPO_ROOT/$p" ;;
  esac
}
