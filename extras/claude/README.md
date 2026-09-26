# extras/claude

Claude Code hooks and status line, installed by `scripts/hooks install` (which `./install` runs when Claude Code and node are present). Other AI tools have their own hook systems; these scripts are Claude Code only.

| File | Event | What it does |
|---|---|---|
| `hooks/block-no-verify.mjs` | PreToolUse, Bash | Denies `git --no-verify`, `git push --force` (not `--force-with-lease`), `HUSKY=0`, and `--no-gpg-sign`. |
| `hooks/validate-written-file.mjs` | PostToolUse, Write/Edit | Flags invalid JSON and unbalanced JSONC right after the write. |
| `hooks/scan-secrets.mjs` | PostToolUse, Write/Edit | Flags a credential written to disk (cloud, model provider, GitHub, GitLab, Slack, Stripe, Supabase keys, private key blocks, hardcoded passwords). |
| `hooks/skill-duplication-guard.mjs` | PostToolUse, Write/Edit | Flags a new SKILL.md whose name another source owns or already installed. |
| `hooks/session-cost-guard.mjs` | UserPromptSubmit | Warns when the session transcript passes 10 MB and 25 MB, a proxy for expensive long-context sessions. |
| `statusline-command.sh` | status line | Model, git branch, folder, and session cost, with a nudge to clear context past $40 or 200k tokens. |

All hooks share `hooks/hook-lib.mjs`: read the payload from stdin (Claude Code does not pass tool input in environment variables) and fail open, so a broken guard never blocks a session.

`scripts/hooks install` merges only these entries into `~/.claude/settings.json`; `scripts/hooks uninstall` removes only them; `scripts/hooks check` reports any configured hook whose script is missing. An existing status line from another source is kept.
