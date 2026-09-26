# ai-workflow-config

One set of AI working preferences and one skills library, installed into every AI tool on a machine with one command. Clone it on any Mac or Linux machine, run `./install`, and every detected tool gets the same rules, the same skills, and (for Claude Code) the same safety hooks.

```bash
git clone git@github.com:geraldmaron/ai-workflow-config.git
cd ai-workflow-config
./install
```

`./install` checks prerequisites (git and zsh are required; node and python3 are optional and named if missing), deploys everything, and ends with a status report. It is safe to re-run. Tools that are not installed are skipped, never treated as errors.

## What you get

| Layer | What it is | Where it goes |
|---|---|---|
| Core preferences | [core/GLOBAL.md](core/GLOBAL.md): intake, grounding and anti-fabrication, verification, reuse, challenge before committing, writing voice, research, cost, secrets, version control. Short on purpose, because it loads in every session. | Each tool's global instruction file ([manifests/managed-files.tsv](manifests/managed-files.tsv)) |
| Skills | [skills/](skills/CATALOG.md): execution craft (implementation verification, root-cause debugging, commit and PR, artifact quality), product leadership (strategy, discovery, metrics, launch readiness, org entry, impact measurement), and personal operations (org history search, knowledge base curation). Loaded on demand. | Every skill root a detected tool reads ([manifests/skill-dest-roots.tsv](manifests/skill-dest-roots.tsv)) |
| Method layer | Intake, adversarial review, investigative research, decision framing, context mapping, requirements, and writing voice (with its AI-tell checker). Owned and shipped by construct; this repo installs it through construct's own installer and reports when it is missing. | Same skill roots |
| Claude Code hooks | Secret scan, written-file validation, bypass guard, skill duplication guard, session cost guard, status line. Merged into `settings.json` without touching anything else. | `~/.claude/hooks`, `~/.claude/settings.json` |

The skills use the open [Agent Skills](https://agentskills.io) format, which Claude Code, Codex, Gemini CLI, Cursor, OpenCode, Copilot, Zed, and IBM Bob all read.

## Commands

```bash
./install [--dry-run] [--no-hooks] [--no-method-layer]
scripts/update [--dry-run]        # git pull --ff-only, then install
scripts/uninstall [--dry-run]     # remove only what this repo installed
scripts/rollback [snapshot]       # undo the last run (or a named one)
scripts/doctor                    # read-only status: drift, method layer, hooks, lint
scripts/verify                    # ask each installed tool whether it loaded the rules
scripts/skills list | show <name> | new <name> | lint | catalog
scripts/evals [--judge=codex|claude]   # routing eval; calls a model, costs tokens
scripts/project-init /path/to/repo [--dry-run]   # project AGENTS.md and CLAUDE.md
tests/run-tests.sh                # safety tests against a scratch home and repo copy
```

## Per-machine settings

Put anything that only applies to one machine in `local/GLOBAL.local.md` (gitignored). It is appended after the shared core on every sync. `local/` also holds the Cursor paste-in rules file and the backup snapshots.

## Safety model

- **Backups first.** Every write or removal is recorded in one snapshot per run, with an index of original paths, so `scripts/rollback` restores exactly what the run changed and removes what it created.
- **Marked regions.** In files other tools also write, only the text between `<!-- ai-workflow-config:begin -->` and `<!-- ai-workflow-config:end -->` changes. A file with duplicated or unpaired markers is refused, not guessed at.
- **Provenance.** Skills this repo deploys carry a `.managed-by` file. Deploy prunes only those, so a renamed or deleted skill leaves nothing behind and skills from other sources are never touched.
- **Lint gate.** `scripts/skills lint` runs before every deploy and blocks it on errors: frontmatter that strict YAML parsers reject, persona or vendor names, machine-specific paths in skills or core, missing gates, record, or stand-down rules, and concepts another source owns. It also warns on AI-writing tells when the writing-voice checker is installed.
- **Nothing pushed.** No script creates a remote or pushes anything.

See [docs/decisions.md](docs/decisions.md) for why each of these exists, [docs/tool-support.md](docs/tool-support.md) for what each tool reads, and [docs/new-device.md](docs/new-device.md) for setting up a new machine.
