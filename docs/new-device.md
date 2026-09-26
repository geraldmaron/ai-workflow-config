# New-device setup

1. Install the AI tools you plan to use on this machine. Any subset works.
2. Clone and install:

   ```bash
   git clone git@github.com:geraldmaron/ai-workflow-config.git
   cd ai-workflow-config
   ./install --dry-run
   ./install
   ```

   If a required tool is missing, `./install` stops and prints the install command for this machine's package manager.
3. For the method layer (intake, adversarial review, research, decision framing, context mapping, requirements, writing voice), install construct, then re-run the method-layer step:

   ```bash
   npm install -g @geraldmaron/construct@alpha
   scripts/method-layer install
   ```

4. Sign in to each tool the usual way (`claude`, `codex login`, `gh auth login`, and so on). No tokens live in this repo.
5. If Cursor is installed, paste `local/cursor-user-rules.md` into Cursor's Settings, then Rules. Cursor stores user rules in the account, with no file to write.
6. Add anything specific to this machine to `local/GLOBAL.local.md`, then run `scripts/sync`.
7. Run `scripts/verify` to confirm each tool actually loaded the rules.

## What stays manual

- Cursor user rules (account storage).
- Hooks for tools other than Claude Code.
- Claude Desktop and claude.ai, which have no file-based instruction or skill directory.
