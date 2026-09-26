---
name: commit-and-pr
description: >-
  Use when committing, choosing a branch, or opening a pull request, before
  running the commit, not after. Covers reading the staged diff in full,
  scoping one logical change per commit, the commit message shape, what must
  never be committed, and a pull request description written for a reviewer
  who has not seen the work, closing in a stated record of what was and was
  not verified. Not for local scratch commits on a private branch that will
  be squashed, and not for a repository with its own strongly enforced
  commit conventions. Match the repository instead and skip this method
  entirely.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Commit and pull request discipline

A commit is a message to whoever has to bisect this line of history in two
years and was not in the room when it was written. Its one job is to explain
why the change exists, at a scope small enough to revert on its own. A pull
request extends that same message to a reviewer who has not seen the work at
all. Both fail the same way when skipped: information that existed for five
minutes in someone's head is gone the moment the terminal closes.

Every step below is mandatory when this method is engaged. A commit made
without reading its own diff is a guess about what it contains.

## 1. Scope, and when to stand down

Engage this method before any commit that another person will read later:
anything landing on a shared branch, anything a reviewer will see, anything
that will be bisected, blamed, or cited months from now. The tell is that
the change will outlive the conversation that produced it.

Stand down for local scratch commits on a private branch that will be
squashed before anyone else sees it, and for a repository that already
enforces its own commit convention through tooling or a strong house style -
in that case the repository's own convention outranks this method, and
matching it is the correct move, not a shortcut.

If it is unclear whether a change is scratch or shared, treat it as shared.
The cost of a slightly-too-careful scratch commit is small; the cost of a
sloppy commit that turns out to be permanent is a worse bisect for years.

## When NOT to use

Local scratch commits on a private branch that will be squashed anyway, and
repositories with their own strongly enforced conventions (a structured
commit format, changelog automation, a commit template). Read the
repository's own recent history and follow it; it always outranks this
method. This method also does not judge the correctness of the code itself:
that judgment belongs to whatever verification step runs before the commit,
and to a harder challenge before anything load-bearing ships.

## 2. Read the diff before staging anything

Read the full staged diff, not a summary of it, before the commit runs.
Debug prints, commented-out experiments, an unrelated formatting sweep, a
stray local configuration file, a large generated file: all of these get
committed by accident, and none of them survive review well. Stage
deliberately, file by file or hunk by hunk when the working tree holds more
than one concern; never stage everything in the working tree without having
looked at what that swept up.

## 3. One logical change per commit

If the message needs the word "and" to describe what changed, it is
probably two commits. A refactor and a behavior change landed together is
the specific combination that makes both review and a later bisect useless:
split them, and land the refactor first, on its own, with no behavior change
riding along with it.

## 4. Never commit what cannot be un-committed

Secrets, credentials, tokens, connection strings, and real user data never
go into a commit, staged or otherwise. If one already has been committed,
deleting it in a later commit does not remove it from history. State that
plainly, treat the secret as compromised, and say it needs rotation rather
than treating the follow-up deletion as a fix.

## 5. Branch before committing to a shared default

If the current branch is the repository's default branch and the change is
not trivially the committer's alone to push straight to it, create a branch
first. A shared default branch with a broken commit on it blocks everyone
who pulls next; a branch blocks only the one change.

## 6. The commit message shape

Exactly this shape:

```
<Imperative-mood summary, under ~72 characters, saying what the change does>

<Why this change exists: what was happening before, what would otherwise
force a reviewer to reconstruct the reasoning from the diff alone>
```

The subject describes what the change does, not the process that produced
it: "Reject expired tokens on refresh" is useful, "fixed bug" or "address
review feedback" is not, because the second kind is meaningless the moment
the surrounding conversation closes. The body is skipped only when the
subject says everything there is to say: a true one-line fix,
stated as one line.

No attribution trailer naming an assistive tool or automated process is
added to the message. The message carries the summary and the body, nothing
else.

A worked example, for the fix described in §6:

```
Reject expired tokens on refresh

The refresh endpoint accepted an expired token if a valid one had been
issued for the same session earlier in the day, because the expiry check
compared against the session's first token instead of the one presented.
Sessions could be extended indefinitely by replaying an old refresh token.
Compares against the presented token's own expiry instead.
```

## 6a. Branch naming, when the repository has no convention of its own

Where the repository already names a branch convention, that convention
wins outright. Absent one, a branch name states what it is for, briefly and
without ceremony: the kind of change and the short subject a reader would
guess from the commit's own subject line. A branch that says nothing more
than a date or a person's own name forces the next reader to open it before
they know what it is.

## 7. The pull request body shape

Written for a reviewer who has not seen the work and has no other way to get
this context except by reading the description. Exactly this shape:

```
## What changes and why
<what changes for the user or the system, and why: the reasoning a
reviewer would otherwise have to reconstruct from the diff>

## How to verify
<the actual commands or steps run to check this, not a description of
testing in general>

## Left out
<what was deliberately not done in this change, and why it was left for
later or for someone else>

## Risk and rollback
<what could go wrong, and how this change is reverted or rolled back if it
does>

## Tested
<what was actually exercised, and what was not, stated honestly, including
gaps>
```

A pull request that says "unit tested; not exercised against production
traffic patterns" is far more useful to the reviewer than one that implies
everything was covered when it was not. Understating coverage is safe;
overstating it costs the reviewer trust the next time this description is
read.

Link the ticket, issue, or decision the change came from wherever one
exists, so the reviewer can check the request against its origin instead of
against the description alone.

## 8. Committing and pushing

Commit or push only when asked to. Do not push to a shared branch, force
push, or bypass a commit or push gate on independent judgment; if a gate
appears to be wrong for the situation, say so and hand the decision to
whoever owns that gate rather than routing around it silently.

## 9. Capability honesty

If the repository's own convention cannot be determined (no accessible
history, no visible template, no linting configuration), say so, apply the
shape in §6 and §7 as the default, and note in the commit or the pull
request body that no repository-specific convention was found to match
against.

## 9a. Composition, if other methods are present

This method governs the commit and the pull request only; it does not judge
whether the code inside the diff is correct or complete. Where a
verification method for the change already ran in this environment, that
verification happens before this method engages, never after: this method
assumes the change is done, not that it becomes done by being described
well. Where a harder, adversarial challenge of load-bearing choices is
available and the diff touches a security boundary, a migration, stored
data, secrets handling, or a public interface, that challenge runs before
the pull request opens, and this method's own gates do not substitute for
it. Both are conditional: this method produces a correctly shaped commit
and pull request on its own, with or without either being present.

## 10. The closing gates

Before a commit or pull request is called final, each gate below is
answered:

1. **Diff read**: the full staged diff was read before staging was
   finalized, not summarized or skipped (§2).
2. **Scope single**: the change is one logical change; anything that needed
   "and" to describe was split (§3).
3. **No secrets**: the diff was checked for credentials, tokens, and real
   user data before it was committed (§4).
4. **Branch correct**: a shared default branch was not committed to
   directly unless the change was trivially the committer's own (§5).
5. **Message shaped**: the commit message follows §6, in full, not just the
   subject line.
6. **Pull request shaped**: the pull request body follows §7, in full,
   including an honest testing statement, or the deliverable says why no
   pull request was opened.
7. **Push authorized**: the commit or push happened because it was asked
   for, not on independent initiative (§8).

## 11. The record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 12. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The diff read, the
scoping, the secrets check, and the message and body shapes are obligations
on whoever commits, made checkable for a reviewer. That visibility is the
enforcement tier this method carries everywhere it is used. An environment
that separately runs a pre-commit check or a secrets scanner adds a
deterministic tier on top; this file works identically with or without one,
and never claims a tier it is not actually running under.
