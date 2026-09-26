# Decisions

Each entry states a decision in force, why it holds, and what enforces it. Superseded decisions are removed, not kept alongside.

## One core file, generated into each tool, never symlinked

`core/GLOBAL.md` is the single source. `scripts/sync` writes it to each detected tool's global instruction file: wholesale where the file is ours alone, inside a marked region where the tool or its owner also writes (Claude Code, Gemini CLI). Symlinks are not used: Claude Code replaces a symlinked config with a real file on write, which silently forks the source, and symlinks break across cloud sync and Windows.

Enforced by: `scripts/doctor` (drift per destination), the marker-count check in `render_marked_region`, tests for idempotency, marker preservation, and duplicated markers.

## The core stays short; anything checkable becomes a mechanism

The core loads into every session of every tool, and adherence falls as simultaneous instructions grow, so each rule gets two to five lines and the depth lives in skills, which load on demand. A rule that is violated is fixed by narrowing its scope or by turning it into a mechanism (a hook, a lint rule, a test), not by adding another rule. New core text is paid for by trimming existing text.

Enforced by: review of `core/GLOBAL.md` diffs; the lint rule that rejects machine-specific paths in `core/`.

## Machine-specific content lives in local/, device rules in ~/AGENTS.md

Anything true on one machine only (a path to a local guide, a secrets launcher) goes in `local/GLOBAL.local.md`, which sync appends after the core and git ignores. Device-level install and secret-handling rules stay in that device's `~/AGENTS.md`, referenced from there rather than copied here.

Enforced by: lint (`core/` may not contain `/Users/`, `/home/`, `~/Developer/`, `~/Documents/`, or `/opt/homebrew/`); a test that the override is appended.

## Skills use the open Agent Skills format and deploy to every root a tool reads

A skill is a folder with `SKILL.md` (frontmatter `name` and `description`, then the method) plus optional `references/`. Only name and description load at startup. Deploy copies whole folders to each root listed in `manifests/skill-dest-roots.tsv`, gated by the same detection expression the core manifest uses. `~/.agents/skills/` is always deployed: it alone covers Codex and Zed and most other tools read it too. Every path in the manifest was read from the vendor's own docs; a path is never added on a secondary source.

Enforced by: the manifest's verification date, printed by `scripts/doctor`; tests for whole-folder copy, detection gating, and prune.

## Construct owns the method layer; this repo installs and checks it

Intake, adversarial review, investigative research, decision framing, context mapping, requirements structuring, and writing voice are owned and versioned by construct (`manifests/skill-ownership.tsv`). This repo does not copy them. `./install` runs construct's own installer (`construct skill install <name> --dir=<root> --force`) for every detected root, and `scripts/doctor` reports any root missing any of the seven.

The strongest failure mode is a fresh machine without construct: the craft skills and core deploy, the method skills do not. Two controls cover it. The core carries a compact always-on baseline for each method (intake, anti-fabrication, challenge before committing, research, writing voice), and doctor names the gap and the fix. Verdict: accepted with controls.

Enforced by: lint (a skill named in the ownership manifest cannot be defined here, and deploy refuses); `scripts/method-layer check` inside doctor; the skill duplication hook at authoring time.

## Skills follow construct's authoring standard, with a machine-checked subset

The standard is construct's `skills/AUTHORING.md`; it is not copied here. `scripts/skills lint` enforces what a machine can check:

- frontmatter opens on line 1, closes, and parses under strict YAML (descriptions are folded `>-` blocks, because a plain value containing `: ` is dropped by strict parsers)
- name matches the folder, description opens with its trigger and stays under 1024 characters
- no host tool or vendor feature names, no machine-specific paths
- a closing gates or record section, an enforcement statement, a stand-down rule
- under 500 lines; the record template and sources live in `references/record.md` and `references/sources.md`

Judgment rules stay the author's job: literal templates over judgment-only prose, composition by conditional mention, and a stand-down that treats applying nothing as a correct outcome.

## Skill names say what the skill does

A name is a functional noun phrase: `org-history-search`, `knowledge-base-curation`, `adversarial-review`. It never names a persona or metaphor (advocate, devil, expert, guru, wizard, hat) or a vendor or product (Slack, Notion, GitHub, Claude), because the skill outlives both.

Enforced by: lint.

## Writing voice: a baseline everywhere, a catalog and a checker in the skill

Prose that reads as machine-written loses the reader. The core's Output rule names the stock tells in one sentence so every tool avoids them with no skill loaded. The full catalog (negate-then-correct, grand closers, reflexive threes, tic words, filler adverbs, chat openers and sign-offs, dashes, bold-label bullets, emoji headings), its budgets, and `voice-check.py` ship in construct's written-voice skill, sourced from Wikipedia's Signs of AI writing and the excess-vocabulary research. Skills are instructions and models copy their style, so lint runs the installed checker over every skill here and warns on tells.

Enforced by: the written-voice closing gate and record; lint warnings on this repo's skills.

## Claude Code settings: this repo owns its entries, never the file

`settings.json`, MCP config, `config.toml`, and auth files mix machine state and secrets and are rewritten by their apps, so this repo never manages them as files. The one exception is narrow: `scripts/hooks install` merges this repo's hook entries and status line into `settings.json`, identified by the script paths they point at, and leaves every other key and hook alone. Uninstall removes only those entries. `scripts/hooks check` runs in doctor and reports any configured hook, from any source, whose script is missing.

Hooks read their payload from stdin and fail open, so a broken guard cannot break a session.

Enforced by: tests for merge, idempotency, foreign-entry preservation, and uninstall; `hook-lib.mjs`.

## Cursor user rules are pasted, not written

Cursor stores user rules in the account, with no local file. Sync writes the paste-in text to `local/cursor-user-rules.md` and doctor reports whether it is current. Project-level Cursor rules are out of scope for the user-level install.

## Every run is reversible

One snapshot directory per run records the pre-run state of every path the run touches, with `index.tsv` mapping each saved copy to its original path, and `-` for paths the run created. `scripts/rollback` restores those paths and removes created ones, and backs itself up first so it can be undone. `scripts/uninstall` removes managed files, managed regions, marked skills, and this repo's hooks, all into one snapshot.

Enforced by: tests for underscore-containing paths, created-file removal, and an uninstall that rolls back.

## macOS and Linux, zsh required, one POSIX entry point

`./install` is POSIX `sh` so it runs before zsh is known to exist; it checks git and zsh, names node and python3 if missing, and prints the install command for the machine's package manager. The scripts behind it are zsh. Detection expressions check a CLI or config directory as well as a macOS app path, so tools are found on Linux. CI runs lint, the tests, and a clean-home install dry run on Ubuntu and macOS.

Rejected for now: Vercel's `npx skills` as the distribution layer (it installs skills but does not sync instruction files, handle marked regions, install hooks, or prune by provenance, and it adds npm as a hard dependency), and `rulesync` (a converter for many tool formats that this repo does not need while one body works everywhere). Either is the escape hatch if the tool count or format divergence grows.

## Routing is measured, not assumed

A skill that never fires is dead weight that costs tokens every session. `evals/routing.tsv` lists requests with the skill that should load (or none), including near neighbors from the method layer. `scripts/evals` shows a model only the catalog, as a host would, and records its picks in `evals/last-run.tsv`. The judge defaults to Codex, a different model family from the author of the cases. It measures description quality, not a host's actual loading behavior, and it is run by hand because it costs tokens.

First recorded run, 2026-09-25, Codex judge, 19-skill catalog: 47 of 48. The miss (a one-line rename routed to implementation-verification) led to a narrower stand-down in that skill; the re-run scored 48 of 48.

## Rejected structures

- **Persona lenses** ("ask the security expert, then the PM"). Construct's own harness found that roles asked to review the same material return the same findings, and an external study of 162 persona variants across four model families found no performance gain. What survives is coverage: which concerns a piece of work touches and what each owes before anyone relies on it.
- **An orchestration runtime** (MCP agent frameworks and similar). None reads SKILL.md, so adopting one means rewriting portable skills into a framework format. Subagents already compose with skills.
