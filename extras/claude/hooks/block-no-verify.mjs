#!/usr/bin/env node
// PreToolUse(Bash): refuse commands that skip the repo's own quality gates.
//
// Bypassing hooks is a human decision, not an agent one. If a pre-commit hook
// is genuinely wrong, the fix is to fix the hook. Denying here is advisory to
// the model, not a security boundary: the user can always run it themselves.
import { readStdin, deny, allow } from './hook-lib.mjs';

const BYPASSES = [
  { re: /\bgit\s+(commit|merge|rebase|push)\b[^|;&]*\s--no-verify\b/, why: '--no-verify skips pre-commit and pre-push hooks' },
  { re: /\bgit\s+commit\b[^|;&]*\s-n\b/, why: '-n on git commit is --no-verify' },
  { re: /\bgit\s+push\b[^|;&]*\s--force\b(?!-with-lease)/, why: '--force can destroy a teammate\'s commits; --force-with-lease is the safe form' },
  { re: /\bHUSKY\s*=\s*0\b/, why: 'HUSKY=0 disables the repo\'s commit hooks' },
  { re: /--no-gpg-sign\b/, why: 'skipping commit signing' },
];

const input = await readStdin();
const command = input?.tool_input?.command ?? '';

const hit = BYPASSES.find(({ re }) => re.test(command));
if (hit) {
  deny(
    `Blocked: ${hit.why}.\n` +
      'If the gate is genuinely wrong, fix the gate or ask the user to run this themselves. ' +
      'Do not work around it silently.',
  );
}
allow();
