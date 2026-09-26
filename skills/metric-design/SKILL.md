---
name: metric-design
description: >-
  Use when defining or repairing product measurement: choosing a North Star
  metric, decomposing it into inputs a team can actually move, writing key
  results that are results rather than deliverables, deciding what "active"
  counts as, setting success criteria for a feature or experiment, or
  diagnosing a number that is being gamed. Produces one output metric, three
  to five inputs with a relationship that reconciles against actuals, a
  named counter-metric and agreed threshold for each, event-level
  definitions with denominator, window, exclusions and owner, and a closing
  record naming where each gate was answered. Stand down before
  product-market fit, where a metric tree gives false precision on numbers
  too small to mean anything, and when the ask is evidencing your own past
  impact, explaining why a number moved, or gating a rollout. Say the method
  was not applied and why.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Metric design

A working method for measurement systems that will carry incentives. It exists
because metric systems fail in exactly two ways, and both are structural rather
than analytical: the number cannot be moved by anyone in the room, or it can be
moved without making the product better.

The fix is one output metric, a small set of inputs the team controls, and a
named way each could be hit dishonestly. Everything else in this file serves
those three.

Every step below is mandatory when this skill is engaged. The gates are not
suggestions, and a metric system is a draft until its record is complete.

## 1. Scope, and when to stand down

Engage when a number is about to carry weight: it will become a target, an
objective, a launch criterion, an experiment's success condition, or a line on a
board slide. Engage when an existing metric is suspected of being gamed, or when
two people in the room mean different things by the same word.

Stand down in these cases, saying in one sentence that the method was not
applied and why. Before product-market fit, where the honest instrument is a few
qualitative signals and a metric tree gives false precision on numbers too small
to mean anything. When the ask is evidencing your own contribution for a review
or update, which starts from work already done rather than designing what to
measure. When the ask is why an existing metric moved, which is an investigation,
not a design. When the ask is a rollout gate, which consumes metrics rather than
defining them. And for a throwaway measure nobody will be held to.

Applying the full apparatus to a number nobody will be held to is a failure of
this skill, not a safe default.

If it is unclear whether a number will carry incentive weight, ask one
question rather than guessing in either direction.

## 2. State the value exchange first

One sentence, before any candidate metric is named:

```
Value exchange: the user gets <X>, and we capture <Y> when they do.
```

Then apply the test that kills most proposed North Stars in under a minute: can
the candidate metric rise while X does not happen? If yes, it measures the
capture, not the value, and it will be hit by squeezing users rather than
serving them.

## 3. Pick one output metric

The output metric is a proxy for value already delivered. It lags by
construction and moves only through the inputs beneath it. A candidate passes
all four tests or it is not the one:

1. **Value proxy.** Rising means users got more of what they came for, not that
   we asked more often.
2. **Movable.** A plausible causal path exists from this team's work to this
   number.
3. **Sensitive.** It changes within one planning cycle. A number that only moves
   annually is a company metric, not a team's output metric.
4. **Single.** One number. Two output metrics means the tradeoff between them
   gets settled informally, by whoever is loudest, on the day it matters.

Revenue and registered users fail test one almost always. Prefer a metric
carrying a unit of value and a frequency: "weekly accounts completing a paid
transfer", not "transfers".

Carry the choice literally, including what was rejected and why:

```
Output metric: <name>
  value proxy: <why rising means value was delivered>
  movable by: <this team's levers>
  sensitivity: moves within <n> weeks
  rejected: <candidate>: fails <which test>
```

Two escape hatches, and say which one you took. For experience quality on an
existing surface, a goals-signals-metrics decomposition with task success as the
output is the better frame, and the goals step is the part people skip. For a
leaky acquisition-to-revenue funnel, a stage decomposition (acquisition,
activation, retention, referral, revenue) gives the structure instead. Pick one
and name it in the deliverable.

## 4. Decompose into three to five inputs

Inputs are leading, directly ownable, and roll mechanically into the output.
Write the relationship as an equation wherever the arithmetic permits:

```
weekly transacting accounts
  = new activated accounts x activation-to-first-transfer rate
  + returning accounts x repeat rate
```

Then check two things, and write both answers down.

**Ownership.** Can one team move each input without waiting on another? If not,
it is a dependency, not an input, and naming it an input transfers
accountability to people with no lever.

**Reconciliation.** Does the arithmetic reproduce last period's actuals within
roughly ten percent? If not, the model of the business is wrong, and no
dashboard will ever say so, because dashboards report the terms and never the
identity between them.

Fewer than three inputs usually means a hidden term. More than five means nobody
holds them.

```
[input] <name> | owner: <team> | dependency-free: <yes/no> | last-period value: <n>
Reconciliation: model <n> vs actual <n>, gap <n> percent | not reconciled: <why>
```

**Capability honesty.** If the environment gives you no access to actuals, you
cannot reconcile. Say so, mark the relationship `[unreconciled: no access to
actuals]`, name who holds the numbers, and deliver the structure anyway. Never
present invented figures in the reconciliation line. A fabricated actual is
worse than a missing one, because the next reader treats it as a baseline.

## 5. Give every metric a named counter-metric

Goodhart's law in practice is not that measurement corrupts. It is that teams
ship the cheapest path to the number, and nobody wrote down what the cheap path
damages. For the output and every input, complete this sentence: *this could be
hit while making the product worse by ___.* The blank is the counter-metric, and
it gets instrumented at the same time, not later.

| Metric being pushed | Cheap path | Counter-metric |
|---|---|---|
| Sessions per user | Notification pressure, fragmented sessions | Mute and unsubscribe rate, sessions per task completed |
| Activation rate | Loosening the activation definition | Week-four retention of the activated cohort |
| Tickets resolved | Closing without solving | Reopen rate, contacts per account |
| Conversion rate | Dark patterns, aggressive trial gating | Refund and chargeback rate, day-30 churn |
| Time in product | Making tasks slower to complete | Task completion time, task success rate |

Every counter-metric needs a threshold agreed in advance. After the fact, the
number is always explained away, and the explanation is always available.

```
[counter] <metric> guards <input or output> | threshold: stop if <metric> <crosses value> | agreed by: <role>
```

A counter-metric with no threshold is a comment, not a guardrail.

## 6. Enforce definitional discipline

Every metric gets a written definition before it gets a chart. "Active" is not a
definition. "Distinct accounts with at least one qualifying action in the
trailing seven days, excluding internal and API-only traffic" is.

```
Definition: <metric name>
  event: <instrumentation name, not the English description>
  denominator: accounts | users | seats | sessions
  window: <length> | rolling | calendar
  exclusions: <internal, bots, test accounts, trials, churned-not-deprovisioned>
  owner: <role> | definition lives at: <where>
  changed on: <when>: <what changed>
```

The denominator is where metrics lie: accounts, users, seats, and
sessions are four different things, and a series that mixes them tells a story
nobody intended. And changing a definition breaks the series. Annotate the
change on the chart, or a reader will take a definitional change for a result.

## 7. Write key results that are results

The dominant objectives-and-key-results failure is key results written as
deliverables: "launch the new pipeline tool", "ship self-serve onboarding".
Those are tasks that can be completed while nothing improves.

Apply the so-what test. Ask "so what?" after each proposed key result. If the
honest answer is another sentence about outcomes, that answer was the real key
result. Iterate until "so what?" has no answer left.

A key result needs a number, a direction, and a baseline:

```
KR: <metric> from <baseline> to <target> by <cycle end>
  baseline measured: <yes: value and date> | <no: instrument this cycle instead>
```

"Improve activation" fails two of the three. If today's value cannot be stated,
the cycle is not ready for a target and should be spent instrumenting.

## 8. Instrument before launch, and know when not to test

Retrofitted analytics means the first cohort has no baseline, so the launch can
only be narrated, never evaluated. The tracking plan (events, properties,
definitions from §6) is part of the specification and part of done. Verify
events through a real end-to-end path before release. The common failure is an
event that fires correctly with a null property, which is useless for
segmentation and looks fine on a count.

Controlled experiments are the default instrument, not a doctrine. Do not run
one when:

- **Underpowered.** Compute the minimum detectable effect for the available
  traffic and duration first. If detecting the expected lift needs more traffic
  than the cycle provides, the result will be a non-result read as "no impact".
- **Interference.** Treatment leaks into control (marketplaces, social graphs,
  shared queues, shared inventory, pricing), violating independence. Use
  switchback, cluster, or geographic designs, or accept a before-and-after with
  controls and say so.
- **Long feedback loops.** If the outcome outlasts the window (renewals,
  enterprise cycles), you are testing a proxy. Agree the proxy's validity up
  front or the debate happens after the result.
- **Irreversible or ethically loaded.** Pricing changes to existing customers,
  security defaults, anything where the losing arm harms real people.
- **The decision is already made.** If it ships regardless, the test buys
  evidence for a narrative. Say so and skip it.

## 9. Detect a metric already being gamed

Five signatures, each checkable without accusing anyone:

- The metric moves while every downstream metric is flat. Volume rose, value did
  not.
- The distribution changed shape but the mean did not. Check percentiles, not
  averages.
- A step change with no matching release, or one landing exactly at a period
  boundary.
- Improvement concentrated in one team, segment, or geography under target
  pressure.
- The definition changed and nobody annotated it.

And the vanity test for any number on a slide: name the decision that would
differ if this number halved. Cumulative totals, page views, and registered
users usually have no such decision, which is exactly why they only ever go up.

## 10. The closing gates

Before the measurement system is called final, each gate below is answered in
the deliverable itself. This is work shown, not work claimed.

1. **Value exchange stated**: one sentence, and the candidate cannot rise
   without it (§2).
2. **One output metric**: passing all four tests, with the rejected candidates
   and their failing test named (§3).
3. **Frame named**: output metric, experience-quality decomposition, or funnel
   stages, chosen explicitly (§3).
4. **Three to five inputs**: each dependency-free and owned by one team (§4).
5. **Relationship reconciles**: model against actuals within roughly ten
   percent, or marked unreconciled with who holds the numbers (§4).
6. **Counter-metrics with thresholds**: one per input and for the output, each
   with a threshold agreed in advance and a name against it (§5).
7. **Definitions complete**: event, denominator, window, exclusions, owner, for
   every term (§6).
8. **Key results are results**: number, direction, baseline; the so-what test
   run (§7).
9. **Instrumentation verified**: events checked end to end, properties non-null,
   before launch (§8).
10. **Gaming pass**: the five signatures checked against the current series, and
    the vanity test applied to anything going on a slide (§9).

If the team cannot recite the inputs from memory, this is a dashboard, not a
measurement system.

## 11. The measurement record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 12. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The shapes, the gates,
and the record are obligations on you, made checkable for the reader. That
visibility is the enforcement tier this skill carries everywhere it goes. An
environment that separately validates definitions or the record's presence adds
a deterministic tier on top; this file works identically with or without one,
and never claims a tier it is not running under.

## When NOT to use

Not for evidencing your own contribution in a review, promotion packet, or
stakeholder update: that starts from work already done, and where an
impact-measurement method is present, route there. Not for investigating why an
existing number moved, which is a debugging or research question and has its own
method, if present. Not for rollout gates and pre-launch checks, which consume
these metrics rather than define them. Where a strategy method is present, its
kernel is the input to §2 rather than an output of this file, and where a
requirements method is present, it names the metric this file defines. Before
product-market fit, a discovery method is the honest instrument, if present.
When a metric is about to become a company target, an adversarial review method
is the right next step, if present: once the incentive is live, the cheap path
gets taken and the counter-metric argument is over. Every one of these neighbors
is optional. This file works standalone and never requires another skill.

Recurring failures worth naming: a North Star that measures capture rather than
value; inputs that are really dependencies; counter-metrics with no threshold; a
definition that lives in someone's head; key results that are shipping dates;
analytics added after launch; and a series annotated nowhere, so a definitional
change reads as a win.

## References

Where this method comes from: [references/sources.md](references/sources.md).
