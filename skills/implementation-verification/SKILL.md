---
name: implementation-verification
description: >-
  Use before writing code in an existing project and before declaring any
  code change complete. Mandatory gates: inspect the project before changing
  it, reuse what exists instead of adding a second variant, run the
  project's real validation path rather than a smaller substitute, observe
  the user-visible outcome on the surface a user would touch, and close with
  a verification record naming each check, what ran, and what was observed.
  Every claim of passing must name the command that produced it. Use when
  implementing a feature or fix, refactoring, changing a schema or
  interface, or answering "is this done". Not for explanation, review, or
  research with no code change, not for throwaway scratch code that is
  never committed, shared, or run against real data, and not for a single
  mechanical edit (a local rename, a formatting fix) that the compiler or
  linter settles. Answer those directly and skip this method entirely.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Implementation verification

A working method for changing code inside a system someone else has to keep
running. It exists because the default behavior of a capable model under
implementation pressure is specific and bad: write plausible code without
reading the project, invent a second variant of something that already exists,
run a narrower command than the one the project actually gates on, and report
success on an outcome that was inferred rather than observed.

Generation is not completion. Every step below is mandatory when this skill is
engaged, and the change is a draft until its verification record is complete.

## 1. Scope, and when to stand down

Engage this method when the change lands in a system with a lifespan: anything
committed, shared, deployed, or run against real data. Features, fixes,
refactors, schema and interface changes, dependency changes, and any moment
someone asks whether the work is done.

Stand down when there is no code change (explanation, review, design, research)
or when the code is disposable and will never be committed, shared, or
pointed at real data. Say in one sentence that the method was not applied, and
why. Applying the full ladder to a scratch script is a failure of this skill,
not a safe default: a method that always interposes teaches the reader to
ignore it.

Match rigor to blast radius. A one-line copy change and a migration are not the
same event, and the gates below scale by how much of them the change touches,
never by whether they are answered at all.

## When NOT to use

Tasks with no code change. Throwaway scratch code. A single mechanical edit,
such as renaming a local variable, where the compiler, type checker, or linter
already proves the change; run that check and move on. A project that honestly has
no validation path at all: say that plainly, run the closest real check that
exists, and record the gap rather than inventing ceremony to simulate rigor the
project never had. If it is unclear whether the change is disposable, assume it
is not.

## 2. Inspect before changing

The project is evidence about how it wants to be changed. Read it before
writing into it. Working through, in order:

1. Project-level instruction and contributor files, if present.
2. Architecture or design notes covering the area.
3. The code paths the change touches, read rather than inferred from names.
4. Existing tests for that area, which state the contract more honestly than
   the docs do.
5. Package manifests and lockfiles, for what is already available.
6. The automated check configuration, for what the project actually gates on.
7. The commands the project really uses for format, lint, type-check, test,
   build, and release.
8. Recent history on the touched paths, where it clarifies intent.

Then name, explicitly: the direct and transitive dependencies the change
touches, and every public interface, schema, contract, event, or stored shape
it can affect. A change whose blast radius was never named was never scoped.

An existing pattern stays unless there is evidence against it. Reuse or extend
it when sound. Replace it only when it is unsafe, obsolete, unmaintainable, or
incompatible with the required outcome, and say which of those it is.

## 3. Reuse before invention

Prefer, in this order, and stop at the first that works: existing project
capability, existing shared utility, existing framework-supported pattern,
maintained ecosystem standard, a small local implementation, a new dependency
or abstraction.

Three rules with no exceptions:

1. **Never create a second variant of something that already exists.** A
   duplicate helper, component, method, configuration, or utility is the most
   expensive thing this skill prevents, because both copies then drift and both
   look correct. Find the original and extend or fix it. Search for it before
   concluding it is absent, and say what you searched for.
2. **Never add a dependency to avoid writing a few understandable lines.** When
   a new dependency is needed, state its maintenance state, license,
   security posture, and what was considered instead, in the change itself.
3. **Never ship a placeholder as an implementation.** No unfinished markers,
   pseudocode, omitted sections, or mocks standing in for essential logic.
   Partial code is acceptable only when the task is explanation or review.

## 4. The validation path, run as the project runs it

Determine the project's real validation path from its automated check
configuration, build scripts, package scripts, task files, or contributor docs.
Run the applicable commands. Do not substitute a smaller or faster command for
the one the project gates on, and do not report a narrower command's success as
the broader one's.

Each check is recorded in exactly this shape, one block per check:

```
Check:    <what it verifies>
Command:  <the exact command run>
Result:   pass | fail | not run
Observed: <what the output actually said, in one line>
```

`not run` is a legitimate result and carries a reason plus the residual risk.
A check that could not be reproduced locally names the job, why not, what ran
instead, and what remains unproven.

**Never say a check passed unless it was executed and it passed.** A remembered
result, an expected result, and an observed result are three different things,
and only the third one may be reported as a pass.

## 5. Prove the user-visible outcome

Before implementing, write the intended outcome as one sentence a
non-implementer could check: what a user would see, click, send, or get back.
After implementing, reproduce that exact sentence on the surface a user would
actually touch, with data shaped like production data.

The proof block, in exactly this shape:

```
Outcome:  <the one-sentence user-visible result, as stated before implementing>
Surface:  <the surface exercised: interface, endpoint, command, flow>
Data:     <what data was used, and how it resembles real data>
Observed: <what actually happened, in the words of what was seen>
Verdict:  proven | not proven: <what could not be run, and what is unverified>
```

A green unit test of a helper, a synthetic fixture, or a stubbed boundary is
not that proof. If the outcome is "the list shows the user's items," then open
the list with production-shaped rows and count them. Validate behavior, not
implementation detail. Mock only at genuine external boundaries, never the
behavior under test. Use the test tooling the project already has, and check
whether it is adequate before introducing another.

Do not report complete on an inferred outcome. If the outcome cannot be
observed in this environment, the verdict is `not proven`, and that word
appears in the summary, not only in the record.

## 6. Rendered-surface inspection

For a change with visible output, render it and look at it. Source that reads
correctly is not a verified interface. At the sizes and modes the project
already supports, walk:

- **Layout**: overlap, clipping, overflow, hidden content, broken stacking,
  misalignment, shifted content, distorted proportions.
- **Text**: wrapping, truncation, contrast, long values, enlarged text.
- **State**: loading, empty, error, and populated; hover, focus, active,
  disabled. Empty and error states are skipped in development and hit first in
  production, so check them first, not last.
- **Access**: focus order, target size, missing text alternatives, heading
  order.
- **Environment**: each supported theme, console errors, failed requests.

**Capability honesty.** If this environment offers no way to render the
surface, you have no visual verification on this change. Say so, name exactly
what went uninspected, state the residual risk, and mark the surface gate
`not done`. Never narrate an inspection that did not happen. Where the project
already carries screenshot or visual-comparison coverage, run it and read the
differences rather than repeating the sweep by hand.

## 7. Before it is called done

Review the full change as a diff, not as a memory of writing it. Remove
accidental edits and debug remnants. Check naming, error handling, security
posture, and backward compatibility on every touched interface. Compare against
the stated acceptance criteria line by line. Then state the residual risk in
one sentence, or state that there is none.

When the change alters a schema, a security boundary, stored data, or a public
interface, passing checks prove it works, not that it should ship. Escalate the
design question separately. If a review discipline for load-bearing decisions
is available in this environment, that is where it belongs.

## 8. The closing gates

Before the change is called complete, each gate below is answered in the
change's own summary. This is work shown, not work claimed:

1. **Project inspected**, with the blast radius named (§2).
2. **Reuse checked**, with what was searched for and what was found (§3).
3. **Validation path run**, with a check block per command (§4).
4. **Outcome observed** on the real surface, with the proof block (§5).
5. **Surface inspected**, or marked not done with the residual risk (§6).
6. **Diff reviewed** against acceptance criteria (§7).
7. **Residual risk** stated, including anything that could not be run.

## 9. The verification record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 10. Composition

Each of these engages only if that discipline is available in this environment,
and this method works identically alone:

- When verification fails and the cause is unknown, a root-cause debugging
  method owns the diagnosis, if present. Do not patch toward a green check.
- When the change is landed, a commit and review method owns the message and
  the description, if present.
- When the change alters a load-bearing decision, an adversarial review method
  owns the challenge, if present.
- When a specialist owner exists for a security, performance, accessibility, or
  data concern the change touches, hand that leg over and integrate the
  finding. Where none exists, check it here and record it as unreviewed by a
  specialist rather than dropping it.

## 11. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The check blocks, the
proof block, the gates, and the record are obligations on you, made checkable
for the reader, and that visibility is the enforcement tier this method carries
everywhere it goes. An environment that separately lints the record's presence,
or that blocks a merge on the same checks, adds a deterministic tier on top.
This file works identically with or without one, and never claims a tier it is
not running under.

## References

Where this method comes from: [references/sources.md](references/sources.md).
