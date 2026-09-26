# Tool support

What each tool reads, as confirmed against that tool's own documentation on the date in the last column. Re-check a row before relying on it once it is more than a few months old; `scripts/doctor` prints the date the skill paths were last checked.

| Tool | Global instructions (mode) | Skills, user level | Detection | Checked |
|---|---|---|---|---|
| Claude Code | `~/.claude/CLAUDE.md` (marked region; never a symlink, which the app replaces with a copy) | `~/.claude/skills/` | `claude` on PATH | 2026-08-22 |
| Codex CLI | `~/.codex/AGENTS.md` (wholesale) | `~/.agents/skills/` only | `codex` on PATH | 2026-08-22 |
| OpenCode | `~/.config/opencode/AGENTS.md` (wholesale) | `~/.config/opencode/skills/`, `~/.claude/skills/`, `~/.agents/skills/` | `opencode` on PATH | 2026-08-22 |
| Gemini CLI | `~/.gemini/GEMINI.md` (marked region; `/memory add` appends at runtime) | `~/.gemini/skills/`, `~/.agents/skills/` | `gemini` on PATH | 2026-08-22 |
| Antigravity | shares `~/.gemini/GEMINI.md` (marked region) | not confirmed | macOS app, or `antigravity` on PATH (Linux command name not confirmed) | 2026-08-22 |
| Copilot CLI | `~/.copilot/instructions/ai-workflow.instructions.md` (wholesale) | `~/.copilot/skills/`, `~/.agents/skills/` | `copilot` on PATH | 2026-08-22 |
| Cursor | none on disk; paste `local/cursor-user-rules.md` into Settings, then Rules | `~/.cursor/skills/`, `~/.agents/skills/` (also reads `~/.claude/skills/`) | `~/.cursor`, the macOS app, or `cursor` on PATH | 2026-08-22 |
| Zed | `~/.config/zed/AGENTS.md` (wholesale) | `~/.agents/skills/` only | `~/.config/zed` or the macOS app | 2026-08-22 |
| IBM Bob | `~/.bob/rules/ai-workflow.md` (wholesale) | `~/.bob/skills/` | `~/.bob` | 2026-09-25 |

The skill format is the open [Agent Skills](https://agentskills.io/specification) spec. `~/.agents/skills/` is deployed on every machine because it alone covers Codex and Zed and is read by most of the others.

Sources: code.claude.com/docs · learn.chatgpt.com/docs/build-skills · opencode.ai/docs/skills · geminicli.com/docs/cli/skills · docs.github.com/copilot/concepts/agents/about-agent-skills · cursor.com/docs/context/skills · zed.dev/docs/ai/skills · bob.ibm.com/docs/ide/features/skills · antigravity.google/docs
