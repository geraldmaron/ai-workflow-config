#!/usr/bin/env zsh
# Safety-behavior tests. Every test runs against a scratch HOME and a scratch
# copy of the repo, so nothing touches the real machine or this checkout.

set -euo pipefail
REAL_REPO="$(cd "$(dirname "${(%):-%x}")/.." && pwd)"
SCRIPTS="$REAL_REPO/scripts"
FAIL=0

pass() { print -r -- "PASS: $1" }
fail() { print -r -- "FAIL: $1"; FAIL=1 }
digest() { cksum < "$1" | awk '{print $1 $2}' }

# write_fixture_skill <dir> <name> - a minimal skill that passes lint, so
# deploy-path tests are not blocked by it.
write_fixture_skill() {
  local dir="$1" fname="$2"
  mkdir -p "$dir"
  print -r -- "---
name: ${fname}
description: Use when exercising the deploy path in tests and nothing else at all. Stand down outside the test suite.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# ${fname}

## 1. Scope, and when to stand down

Engage only inside the test suite. Stand down everywhere else.

## 2. The closing gates

1. Fixture used only in tests.

## 3. The record

\`\`\`
Fixture record
- Gate: answered, see <where>
\`\`\`

## 4. What is enforced, and by what

Nothing here is machine-enforced by this file.

## When NOT to use

Outside the test suite.
" > "$dir/SKILL.md"
}

# scratch_repo [skill-name...] - a repo copy with the real core and manifests
# and only the named fixture skills. Prints its path.
scratch_repo() {
  local dir name
  dir=$(mktemp -d)
  cp -R "$REAL_REPO/core" "$REAL_REPO/manifests" "$dir/"
  mkdir -p "$dir/skills"
  for name in "$@"; do write_fixture_skill "$dir/skills/$name" "$name"; done
  print -r -- "$dir"
}

TMPHOME=$(mktemp -d)
CLEANUP=("$TMPHOME")
trap 'rm -rf "${CLEANUP[@]}"' EXIT
export HOME="$TMPHOME"
mkdir -p "$HOME/.codex" "$HOME/.gemini" "$HOME/.config/opencode"

# Stand-ins for AI tool CLIs, so detection is under the test's control and does
# not depend on what happens to be installed on the machine running the tests.
FAKEBIN=$(mktemp -d)
CLEANUP+=("$FAKEBIN")
for tool in codex gemini opencode; do
  print -r -- $'#!/bin/sh\nexit 0' > "$FAKEBIN/$tool"
  chmod +x "$FAKEBIN/$tool"
done
# Only the stand-ins and the system directories, so real AI tools installed on
# this machine are invisible to detection. zsh and python3 live in these on
# macOS and on Linux distributions alike.
BASEPATH="$FAKEBIN:/usr/bin:/bin"

export REPO_ROOT=$(scratch_repo keeper)
CLEANUP+=("$REPO_ROOT")

# --- sync: wholesale write on empty file ---
PATH="$BASEPATH" "$SCRIPTS/sync" >/dev/null 2>&1 || true
if [[ -f "$HOME/.codex/AGENTS.md" ]] && grep -q "MANAGED BY ai-workflow-config" "$HOME/.codex/AGENTS.md"; then
  pass "wholesale destination created with managed header"
else
  fail "wholesale destination missing or unheadered"
fi

# --- sync: idempotency ---
before=$(digest "$HOME/.codex/AGENTS.md")
PATH="$BASEPATH" "$SCRIPTS/sync" >/dev/null 2>&1 || true
if [[ "$before" == "$(digest "$HOME/.codex/AGENTS.md")" ]]; then
  pass "idempotent: unchanged source produces unchanged output"
else
  fail "second sync run changed output with no source edits"
fi

# --- sync: marked region preserves content outside markers ---
print -r -- "# my hand-written gemini notes" > "$HOME/.gemini/GEMINI.md"
PATH="$BASEPATH" "$SCRIPTS/sync" >/dev/null 2>&1 || true
if grep -q "my hand-written gemini notes" "$HOME/.gemini/GEMINI.md" && grep -q "ai-workflow-config:begin" "$HOME/.gemini/GEMINI.md"; then
  pass "marked-region preserves pre-existing hand-written content"
else
  fail "marked-region write clobbered existing content"
fi

# --- sync: duplicated markers are refused, not guessed at ---
dup="$HOME/.gemini/GEMINI.md"
cat "$dup" "$dup" > "$dup.tmp" && mv "$dup.tmp" "$dup"
before=$(digest "$dup")
if PATH="$BASEPATH" "$SCRIPTS/sync" >/dev/null 2>&1; then
  fail "sync accepted a file with duplicated markers"
elif [[ "$before" == "$(digest "$dup")" ]]; then
  pass "duplicated markers stop sync and leave the file untouched"
else
  fail "sync refused duplicated markers but still changed the file"
fi
print -r -- "# my hand-written gemini notes" > "$dup"

# --- sync: dry-run makes no filesystem changes ---
rm -f "$HOME/.config/opencode/AGENTS.md"
PATH="$BASEPATH" "$SCRIPTS/sync" --dry-run >/dev/null 2>&1 || true
if [[ ! -f "$HOME/.config/opencode/AGENTS.md" ]]; then
  pass "dry-run wrote nothing to a missing destination"
else
  fail "dry-run wrote a file to disk"
fi

# --- sync: absent tools are skipped, not errors ---
if out=$(PATH="/usr/bin:/bin:${PATH}" HOME="$(mktemp -d)" "$SCRIPTS/sync" --dry-run 2>&1); then
  if [[ "$out" == *"skip"* ]]; then
    pass "missing tools are skipped, not treated as errors"
  else
    fail "expected skip messages not found"
  fi
else
  fail "sync exited nonzero when tools were simply absent"
fi

# --- sync: the per-machine override is appended after the shared core ---
mkdir -p "$REPO_ROOT/local"
print -r -- "machine-only override line" > "$REPO_ROOT/local/GLOBAL.local.md"
PATH="$BASEPATH" "$SCRIPTS/sync" >/dev/null 2>&1 || true
if grep -q "machine-only override line" "$HOME/.codex/AGENTS.md"; then
  pass "local/GLOBAL.local.md is appended on sync"
else
  fail "local override was not appended"
fi
rm -f "$REPO_ROOT/local/GLOBAL.local.md"
PATH="$BASEPATH" "$SCRIPTS/sync" >/dev/null 2>&1 || true

# --- lint: the real library passes ---
if REPO_ROOT="$REAL_REPO" "$SCRIPTS/skills" lint >/dev/null 2>&1; then
  pass "shipped skills library passes lint"
else
  fail "shipped skills library fails lint (run: scripts/skills lint)"
fi

# --- lint: catches a defective skill ---
SCRATCH=$(mktemp -d); CLEANUP+=("$SCRATCH")
mkdir -p "$SCRATCH/skills/broken"
print -r -- '---
name: mismatched
description: Reviews things.
---

# Broken
' > "$SCRATCH/skills/broken/SKILL.md"
lint_out=$(REPO_ROOT="$SCRATCH" "$SCRIPTS/skills" lint 2>&1 || true)
missed=""
for expected in "does not match directory" "must open with a trigger" "stand-down rule"; do
  [[ "$lint_out" == *"$expected"* ]] || missed="$missed '$expected'"
done
if [[ -z "$missed" ]]; then
  pass "lint detects name mismatch, bad description, and missing boundary"
else
  fail "lint missed:$missed"
fi

# --- lint: names must be functional, not personas or vendors ---
SCRATCH=$(scratch_repo devils-advocate); CLEANUP+=("$SCRATCH")
lint_out=$(REPO_ROOT="$SCRATCH" "$SCRIPTS/skills" lint 2>&1 || true)
if [[ "$lint_out" == *"persona, metaphor, or vendor"* ]]; then
  pass "lint rejects a persona-named skill"
else
  fail "lint accepted a persona-named skill"
fi

# --- lint: a description strict YAML parsers would reject is caught ---
SCRATCH=$(scratch_repo keeper); CLEANUP+=("$SCRATCH")
sed -i.bak 's/^description: Use when exercising the deploy path in tests/description: Use when exercising the deploy path: in tests/' "$SCRATCH/skills/keeper/SKILL.md"
lint_out=$(REPO_ROOT="$SCRATCH" "$SCRIPTS/skills" lint 2>&1 || true)
if [[ "$lint_out" == *"plain YAML value"* ]]; then
  pass "lint rejects a plain YAML description containing ': '"
else
  fail "lint accepted a description strict YAML parsers reject"
fi

# --- lint: core preferences must not carry a machine-specific path ---
SCRATCH=$(scratch_repo keeper); CLEANUP+=("$SCRATCH")
print -r -- "Read ~/Developer/Guides/secret.md first." >> "$SCRATCH/core/GLOBAL.md"
lint_out=$(REPO_ROOT="$SCRATCH" "$SCRIPTS/skills" lint 2>&1 || true)
if [[ "$lint_out" == *"core/GLOBAL.md"*"machine-specific path"* ]]; then
  pass "lint rejects a machine-specific path in core"
else
  fail "lint accepted a machine-specific path in core"
fi

# --- deploy: whole-directory copy, and prune of what the repo dropped ---
SCRATCH=$(scratch_repo keeper); CLEANUP+=("$SCRATCH")
mkdir -p "$SCRATCH/skills/keeper/references"
print -r -- "supporting reference material" > "$SCRATCH/skills/keeper/references/notes.md"
mkdir -p "$HOME/.agents/skills/stale-skill"
print -r -- "left over from a deleted skill" > "$HOME/.agents/skills/stale-skill/SKILL.md"
print -r -- "deployed by ai-workflow-config" > "$HOME/.agents/skills/stale-skill/.managed-by"
PATH="$BASEPATH" REPO_ROOT="$SCRATCH" "$SCRIPTS/deploy" >/dev/null 2>&1 || true
if [[ -f "$HOME/.agents/skills/keeper/references/notes.md" ]]; then
  pass "deploy copies supporting files, not just SKILL.md"
else
  fail "deploy dropped a skill's supporting files"
fi
if [[ ! -d "$HOME/.agents/skills/stale-skill" ]]; then
  pass "deploy prunes skills the repo no longer defines"
else
  fail "orphaned skill survived deploy and will keep firing"
fi

# --- deploy: a renamed skill leaves nothing behind under its old name ---
mv "$SCRATCH/skills/keeper" "$SCRATCH/skills/renamed-keeper"
sed -i.bak 's/^name: keeper$/name: renamed-keeper/' "$SCRATCH/skills/renamed-keeper/SKILL.md" && rm -f "$SCRATCH/skills/renamed-keeper/SKILL.md.bak"
PATH="$BASEPATH" REPO_ROOT="$SCRATCH" "$SCRIPTS/deploy" >/dev/null 2>&1 || true
if [[ -d "$HOME/.agents/skills/renamed-keeper" && ! -d "$HOME/.agents/skills/keeper" ]]; then
  pass "a renamed skill is deployed under its new name and pruned under its old one"
else
  fail "rename left the old skill behind or skipped the new one"
fi

# --- deploy: lint failure blocks deployment ---
SCRATCH=$(mktemp -d); CLEANUP+=("$SCRATCH")
cp -R "$REAL_REPO/core" "$REAL_REPO/manifests" "$SCRATCH/"
mkdir -p "$SCRATCH/skills/no-boundary"
print -r -- '---
name: no-boundary
description: Use when testing that a failing lint blocks deployment entirely.
---

# No boundary
' > "$SCRATCH/skills/no-boundary/SKILL.md"
if PATH="$BASEPATH" REPO_ROOT="$SCRATCH" "$SCRIPTS/deploy" >/dev/null 2>&1; then
  fail "deploy ran on a library that fails lint"
elif [[ ! -d "$HOME/.agents/skills/no-boundary" ]]; then
  pass "failing lint blocks deploy and writes nothing"
else
  fail "lint gate exited nonzero but still wrote skills"
fi

# --- deploy: skill roots follow real tool detection ---
SCRATCH=$(scratch_repo keeper); CLEANUP+=("$SCRATCH")
rm -rf "$HOME/.agents" "$HOME/.claude" "$HOME/.gemini" "$HOME/.copilot"
PATH="$BASEPATH" REPO_ROOT="$SCRATCH" "$SCRIPTS/deploy" >/dev/null 2>&1 || true
if [[ -d "$HOME/.agents/skills/keeper" ]]; then
  pass "the tool-neutral ~/.agents/skills root deploys unconditionally"
else
  fail "~/.agents/skills did not receive the skill"
fi
if [[ -d "$HOME/.gemini/skills/keeper" ]]; then
  pass "a detected tool (fake gemini on PATH) receives its own skill root"
else
  fail "gemini was detectable on PATH but its skill root was not populated"
fi
if [[ ! -d "$HOME/.copilot/skills" && ! -d "$HOME/.claude/skills" ]]; then
  pass "undetected tools receive no skill deploy"
else
  fail "a skill root was populated for a tool that was not detected"
fi

# --- deploy: foreign skills survive; ours carry a provenance marker ---
mkdir -p "$HOME/.agents/skills/from-another-tool"
print -r -- "installed by a different tool entirely" > "$HOME/.agents/skills/from-another-tool/SKILL.md"
PATH="$BASEPATH" REPO_ROOT="$SCRATCH" "$SCRIPTS/deploy" >/dev/null 2>&1 || true
if [[ -f "$HOME/.agents/skills/from-another-tool/SKILL.md" ]]; then
  pass "a skill from another tool survives deploy and prune"
else
  fail "prune destroyed a skill this repo did not deploy"
fi
if [[ -f "$HOME/.agents/skills/keeper/.managed-by" ]]; then
  pass "repo-deployed skills carry a provenance marker"
else
  fail "deployed skill has no .managed-by marker"
fi

# --- ownership: a concept another source owns cannot be redefined here ---
SCRATCH=$(scratch_repo adversarial-review); CLEANUP+=("$SCRATCH")
own_out=$(REPO_ROOT="$SCRATCH" "$SCRIPTS/skills" lint 2>&1 || true)
if [[ "$own_out" == *"owned by 'construct'"* ]]; then
  pass "lint rejects a skill whose concept another source owns"
else
  fail "ownership policy did not fire on a duplicated concept"
fi
if PATH="$BASEPATH" REPO_ROOT="$SCRATCH" "$SCRIPTS/deploy" >/dev/null 2>&1; then
  fail "deploy ran on a library that violates ownership policy"
else
  pass "ownership violation blocks deploy"
fi

# --- rollback: restores paths containing underscores, removes what the run created ---
SCRATCH=$(scratch_repo keeper); CLEANUP+=("$SCRATCH")
mkdir -p "$HOME/some_tool/nested_dir"
print -r -- "original" > "$HOME/some_tool/nested_dir/config_file.md"
REPO_ROOT="$SCRATCH" AIWF_BACKUP_TS=rollback-test zsh -c '
  source "'"$SCRIPTS"'/lib.sh"
  backup_path "$HOME/some_tool/nested_dir/config_file.md"
  backup_path "$HOME/some_tool/created_by_run.md"' 2>/dev/null
print -r -- "changed" > "$HOME/some_tool/nested_dir/config_file.md"
print -r -- "new" > "$HOME/some_tool/created_by_run.md"
REPO_ROOT="$SCRATCH" "$SCRIPTS/rollback" rollback-test >/dev/null 2>&1 || true
if [[ "$(<"$HOME/some_tool/nested_dir/config_file.md")" == "original" && ! -e "$HOME/some/tool" ]]; then
  pass "rollback restores a path containing underscores to that exact path"
else
  fail "rollback restored to the wrong path or did not restore"
fi
if [[ ! -e "$HOME/some_tool/created_by_run.md" ]]; then
  pass "rollback removes files the run created"
else
  fail "rollback left behind a file the run created"
fi

# --- uninstall: returns the machine to its pre-install state, and rollback undoes it ---
SCRATCH=$(scratch_repo keeper); CLEANUP+=("$SCRATCH")
UHOME=$(mktemp -d); CLEANUP+=("$UHOME")
mkdir -p "$UHOME/.gemini" "$UHOME/.agents/skills/from-another-tool"
print -r -- "# notes that predate the install" > "$UHOME/.gemini/GEMINI.md"
print -r -- "foreign" > "$UHOME/.agents/skills/from-another-tool/SKILL.md"
gemini_before=$(digest "$UHOME/.gemini/GEMINI.md")
HOME="$UHOME" PATH="$BASEPATH" REPO_ROOT="$SCRATCH" "$SCRIPTS/deploy" >/dev/null 2>&1 || true
HOME="$UHOME" PATH="$BASEPATH" REPO_ROOT="$SCRATCH" "$SCRIPTS/uninstall" >/dev/null 2>&1 || true
if [[ "$gemini_before" == "$(digest "$UHOME/.gemini/GEMINI.md")" && ! -e "$UHOME/.codex/AGENTS.md" ]]; then
  pass "uninstall restores shared files byte for byte and removes managed ones"
else
  fail "uninstall left managed content behind or damaged a shared file"
fi
if [[ ! -d "$UHOME/.agents/skills/keeper" && -f "$UHOME/.agents/skills/from-another-tool/SKILL.md" ]]; then
  pass "uninstall removes this repo's skills and keeps everyone else's"
else
  fail "uninstall removed the wrong skills"
fi
HOME="$UHOME" REPO_ROOT="$SCRATCH" "$SCRIPTS/rollback" >/dev/null 2>&1 || true
if [[ -d "$UHOME/.agents/skills/keeper" ]] && grep -q "ai-workflow-config:begin" "$UHOME/.gemini/GEMINI.md"; then
  pass "rollback undoes an uninstall"
else
  fail "rollback did not restore what uninstall removed"
fi

# --- hooks: install merges with foreign entries; uninstall removes only ours ---
if command -v node >/dev/null 2>&1; then
  HHOME=$(mktemp -d); CLEANUP+=("$HHOME")
  mkdir -p "$HHOME/.claude"
  print -r -- '{"model":"x","hooks":{"PreToolUse":[{"matcher":"Bash","hooks":[{"type":"command","command":"node /elsewhere/theirs.mjs"}]}]},"statusLine":{"type":"command","command":"bash /elsewhere/status.sh"}}' > "$HHOME/.claude/settings.json"
  HOME="$HHOME" REPO_ROOT="$REAL_REPO" "$SCRIPTS/hooks" install >/dev/null 2>&1 || true
  HOME="$HHOME" REPO_ROOT="$REAL_REPO" "$SCRIPTS/hooks" install >/dev/null 2>&1 || true
  counts=$(node -e '
    const s = require(process.argv[1]);
    const cmds = Object.values(s.hooks).flat().flatMap((e) => e.hooks.map((h) => h.command));
    console.log([cmds.filter((c) => c.includes("theirs.mjs")).length,
                 cmds.filter((c) => c.includes("block-no-verify.mjs")).length,
                 s.model, s.statusLine.command.includes("/elsewhere/") ? "kept" : "replaced"].join(" "));
  ' "$HHOME/.claude/settings.json")
  if [[ "$counts" == "1 1 x kept" ]]; then
    pass "hooks install merges once, keeps foreign hooks, other keys, and a foreign status line"
  else
    fail "hooks install result was: $counts (want: 1 1 x kept)"
  fi
  HOME="$HHOME" REPO_ROOT="$REAL_REPO" "$SCRIPTS/hooks" uninstall >/dev/null 2>&1 || true
  left=$(node -e '
    const s = require(process.argv[1]);
    console.log(Object.values(s.hooks ?? {}).flat().flatMap((e) => e.hooks.map((h) => h.command)).join(","));
  ' "$HHOME/.claude/settings.json")
  if [[ "$left" == "node /elsewhere/theirs.mjs" && ! -e "$HHOME/.claude/hooks/block-no-verify.mjs" ]]; then
    pass "hooks uninstall removes only this repo's hooks and files"
  else
    fail "hooks uninstall left: $left"
  fi
else
  print -r -- "SKIP: hooks tests (node not installed)"
fi

# --- install: a missing required tool stops the install with a fix ---
NOZSH=$(mktemp -d); CLEANUP+=("$NOZSH")
for c in dirname sed git; do
  p=$(command -v "$c") && ln -s "$p" "$NOZSH/$c"
done
if out=$(PATH="$NOZSH" /bin/sh "$REAL_REPO/install" --dry-run 2>&1); then
  fail "install continued without zsh"
elif [[ "$out" == *"MISSING  zsh"* ]]; then
  pass "install stops when zsh is missing and names the fix"
else
  fail "install failed without naming the missing tool: ${out:0:120}"
fi

echo
if (( FAIL )); then
  echo "one or more tests FAILED"
  exit 1
else
  echo "all tests passed"
fi
