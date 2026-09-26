---
name: root-cause-debugging
description: >-
  Use when something is broken or anomalous and the cause is not yet known,
  whether the symptom is a failing test, an error in logs, a regression, "it
  works locally", or a metric that dropped, a funnel step that fell off, a
  ticket spike, a number nobody can explain. Mandatory gates: reproduce
  deterministically before touching anything, read the whole error rather
  than its first line, establish what changed, test one falsifiable
  hypothesis by observation rather than by patching, explain the entire
  symptom including the incidental parts, prove the fix in both directions,
  and close with a diagnosis record naming where each gate was answered. Not
  for a cause the error already names (just fix it), not for code that has
  never run (that is implementation), and not for an open question with no
  known-good baseline. Skip this method entirely for those.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Root-cause debugging

A working method for explaining a failure well enough that the fix is a
consequence rather than a coincidence. It exists because the default behavior
of a capable model, and of a capable engineer under time pressure, is specific
and bad: read some code, form a plausible theory, change something, watch the
symptom disappear, and call it fixed.

Symptom relief is not diagnosis. A fix you cannot explain is a coincidence you
have not caught yet. The same failure mode is worse when the broken thing is a
number, because a plausible story about a metric is socially rewarded long
before anyone checks it.

Every step below is mandatory when this skill is engaged, and the diagnosis is
a draft until its record is complete.

## 1. Scope, and when to stand down

Engage this method when something observably misbehaves and the cause is
unknown: a failing test, an exception, a regression, an
environment-dependent failure, corrupt or missing data, an unexplained
performance change, or a metric, funnel, or volume that moved without a known
reason.

Stand down when the cause is already named. An error that states the missing
import, the typo, the wrong version pin, or the unset variable is not a mystery
and does not need this apparatus. Fix it, say in one sentence that the method
was not applied because the cause was stated in the output, and move on.
Ceremony on a five-second problem is waste, and a method that always interposes
teaches the reader to ignore it.

If it is unclear whether the visible error is the real cause or a downstream
consequence, that is itself a reason to engage, not to guess.

## When NOT to use

A cause the output already names. Code that has never run: that is
implementation, not debugging. Understanding an unfamiliar system in general,
rather than explaining one specific failure. Designing or redefining a metric,
as opposed to explaining why an existing one moved. An open question with no
known-good baseline to compare against is research, not debugging.

If reproduction is impossible (a one-off production event, no access,
data since expired), do not abandon the method and do not present a guess as a
diagnosis. State the best-supported hypothesis as a hypothesis, mark the
reproduction gate `not done`, and make the fix's uncertainty visible.

## 2. Reproduce before touching anything

Get to a command, request, or click sequence that fails on demand, then write
it down in exactly this shape:

```
Reproduction
- Command:     <the exact invocation, request, or steps>
- Environment: <where it runs, and what about that environment matters>
- Data:        <the input or state required, and how to get it>
- Frequency:   deterministic | intermittent: <fails <n> in <n> runs>
- Observed:    <the exact failure, quoted from output, not paraphrased>
- Expected:    <what should have happened instead>
```

**Do not change code before this block exists.** A fix applied to an
unreproduced failure cannot be verified, only hoped at.

If it fails only sometimes, find what varies: ordering, timing, concurrency,
caching, data shape, clock, locale, environment. Pin that down until it fails
on demand, or until the block can say precisely what makes it intermittent.
Intermittent is a description of your knowledge, not a property of the bug.

## 3. Read the whole error

The whole trace, the real log line, the actual exit code. Not a paraphrase and
not the first frame. Note the precise failing value, the precise expected
value, and the exact point where they diverge. Most failures called mysterious
are stated plainly in output nobody read to the end.

Where the interesting frame sits inside library code, keep reading outward
until you reach the last line of your own code that chose the failing value.
That line, not the crash site, is usually the subject of the diagnosis.

## 4. Establish what changed

Did this ever work? A regression has a change behind it, and finding the change
is cheaper than re-deriving the system from scratch.

- History on the affected paths, narrowed by bisection where the tooling
  allows it.
- Dependency and lock changes, including transitive ones.
- Configuration, environment, feature flags, and permissions.
- The difference between the environment where it works and the one where it
  does not, stated as a list, not as an impression.

If nothing changed and it never worked, say so. That is a different
investigation and a different fix.

## 5. One falsifiable hypothesis at a time

State it so it can be proven wrong: "the token has expired by the time the
retry fires," not "something is wrong with authentication." Then name the
single observation that would disprove it, and go make that observation.

**Test by observation, not by patching.** Add a log line, set a breakpoint,
print the value, query the store, inspect the payload, capture the request.
Changing code to see whether the symptom moves conflates the test with the cure
and destroys the evidence you needed. Keep going until you can point at the
exact line, value, or condition responsible.

Each hypothesis is recorded, in exactly this shape:

```
Hypothesis: <the falsifiable statement>
Refuted by: <the observation that would disprove it>
Test:       <what was actually observed, and how>
Verdict:    supported | refuted | inconclusive: <what is still missing>
```

Refuted hypotheses stay in the record. They are the evidence that the surviving
one survived something.

## 6. Explain the whole symptom

The cause must account for everything observed, including the parts that look
incidental: why it fails only on one day of the week, why only for one account,
why the retry succeeds, why the log is empty. An explanation that covers most
of the evidence is usually the wrong explanation with a coincidence attached.

The cause and its evidence, in exactly this shape:

```
Cause
- Statement:   <the mechanism, in one sentence a stranger could act on>
- Evidence:    <the observations that establish it, each one something seen>
- Accounts for: <each element of the symptom, mapped to the mechanism>
- Unexplained: none | <what the cause does not account for, stated plainly>
- Confidence:  high | medium | low, because <what would raise it>
```

An unexplained residual stays unexplained out loud. Never round it into the
story that fits.

## 7. Diagnosing a number rather than a trace

When the broken thing is a metric, the same discipline holds and two extra
gates apply first.

1. **Confirm the number is real before explaining it.** Most drops are
   measurement: a tracking change, a renamed event, a filter change, a
   time-zone or definition change, a failed job, a late-arriving pipeline.
   Establish whether the *measurement* changed before theorizing about whether
   *behavior* changed. Explaining an artifact of instrumentation is the most
   common wasted week in product work.
2. **Segment before hypothesizing.** Split by platform, region, version,
   cohort, acquisition source, and new versus existing. A uniform move across
   every segment is nearly always measurement. A move isolated to one segment
   names its own cause.
3. **Establish the counterfactual.** Seasonality, day-of-week, or a return to
   trend after a promotion. Compare against the same window in prior periods,
   not against last week.
4. **Build the chronology of what else changed** in the same window: releases,
   pricing, campaigns ending, upstream outages, a competitor's move.
5. **Size it before escalating.** Magnitude, affected population, and the
   revenue or retention consequence. "Signups down four percent for one
   platform in one region" earns a proportionate response. "Signups are down"
   starts a fire drill.

Report the cause with its confidence level and say what was ruled out. What was
ruled out is the part a hostile reader checks first.

## 8. Fix, prove, and close the hole

1. **Fix the cause, not the symptom.** If the fix does not follow from the
   cause statement, one of the two is wrong.
2. **Prove it in both directions.** Run the reproduction from §2 and watch it
   pass. Then restore the cause (revert the fix, restore the bad input) and
   watch it fail again. A fix never shown to control the symptom in both
   directions is unproven, and the record says so.
3. **Add the regression test** that would have caught this, exercising the
   reproduction rather than the fix's internals.
4. **Ask where else this exists.** A class of mistake found once is rarely
   present once. Search for the pattern and state what the search covered.

For the change itself, an implementation verification method owns the
validation path, if one is present in this environment.

## 9. The closing gates

Before the diagnosis is called final, each gate below is answered in the
deliverable itself:

1. **Reproduced**, with the reproduction block (§2).
2. **Whole error read**, with the failing and expected values named (§3).
3. **What changed established**, or stated as never-worked (§4).
4. **Hypotheses tested by observation**, with refuted ones retained (§5).
5. **Whole symptom explained**, with the unexplained residual named (§6).
6. **Measurement ruled out**, where the symptom is a number (§7).
7. **Fix proven in both directions**, on the reproduction (§8).
8. **Hole closed**, with the regression test and where else this exists (§8).

## 10. The diagnosis record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 11. Composition

Each of these engages only if that discipline is available here, and this
method works identically alone:

- An implementation verification method owns the fix's validation path, if
  present.
- A commit and review method owns landing the change, if present.
- A metric design method owns the repair when the definition or the
  instrumentation was itself the bug, if present.
- An adversarial review method owns the challenge when the diagnosis is going
  to decision-makers as the explanation, or when the fix touches data, a
  migration, or a security boundary, if present.
- Where an owner exists for the failing component, the pipeline, or an upstream
  service, hand them that leg and integrate the finding. Where none exists,
  investigate it here and record it as unreviewed by a specialist.

## 12. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The reproduction block,
the hypothesis blocks, the cause block, and the record are obligations on you,
made checkable for the reader, and that visibility is the enforcement tier this
method carries everywhere it goes. An environment that separately lints the
record's presence, or that requires a regression test before a merge, adds a
deterministic tier on top. This file works identically with or without one, and
never claims a tier it is not running under.

## References

Where this method comes from: [references/sources.md](references/sources.md).
