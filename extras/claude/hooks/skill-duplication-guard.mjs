#!/usr/bin/env node
// PostToolUse(Write|Edit|MultiEdit): catch a skill being authored that already
// exists somewhere else on this machine.
//
// The global instruction file already says to search for an existing
// implementation before creating a new one. That rule is context, not
// enforcement, and it is scoped to "the project", so it does not fire when the
// existing implementation lives in a different repo or is installed in a host's
// skills directory. This check does, deterministically, at the moment the file
// is written rather than at deploy time.
import { readFileSync, existsSync } from 'node:fs';
import { join, basename, dirname } from 'node:path';
import { homedir } from 'node:os';
import { readStdin, targetFile, flag, ok } from './hook-lib.mjs';

const input = await readStdin();
const file = targetFile(input);
if (!/\/skills\/[^/]+\/SKILL\.md$/.test(file)) ok();

const name = basename(dirname(file));
const hits = [];

// 1. Declared ownership: another source owns this concept by policy.
for (const manifest of findOwnershipManifests(file)) {
  try {
    for (const line of readFileSync(manifest, 'utf8').split('\n')) {
      if (!line.trim() || line.startsWith('#')) continue;
      const [owner, skill, note] = line.split('\t');
      if (skill?.trim() === name) hits.push(`'${owner}' owns this concept by policy (${note?.trim() ?? ''}); ${manifest}`);
    }
  } catch {}
}

// 2. Already installed under this name in a host's skills directory.
const roots = ['.claude/skills', '.agents/skills', '.gemini/skills', '.cursor/skills', '.copilot/skills', '.bob/skills'];
for (const root of roots) {
  const dir = join(homedir(), root, name);
  // A directory this repo deployed is our own copy, not a competing one.
  if (existsSync(join(dir, 'SKILL.md')) && !existsSync(join(dir, '.managed-by'))) {
    hits.push(`already installed by another source at ~/${root}/${name}`);
  }
}

if (hits.length) {
  flag(
    `SKILL DUPLICATION: '${name}' already exists elsewhere.\n` +
      hits.map((h) => `  - ${h}`).join('\n') +
      '\n\nRead the existing one before continuing. Extend or defer to it rather than ' +
      'maintaining a second version: two skills that fire on the same situation collide in ' +
      "the host's skills directory and whichever tool deployed last silently wins. " +
      'If this really is a distinct concept, rename it so the trigger does not overlap.',
  );
}
ok();

/** Ownership manifests to consult: the one beside this skill, if any. */
function findOwnershipManifests(skillFile) {
  const found = [];
  let dir = dirname(dirname(dirname(skillFile))); // up out of skills/<name>/
  for (let i = 0; i < 3 && dir && dir !== '/'; i++) {
    const candidate = join(dir, 'manifests', 'skill-ownership.tsv');
    if (existsSync(candidate)) found.push(candidate);
    dir = dirname(dir);
  }
  return found;
}
