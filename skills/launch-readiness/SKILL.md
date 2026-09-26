---
name: launch-readiness
description: >-
  Use when planning or gating a product launch, feature rollout, or general
  availability: assigning a launch tier, sequencing the cross-functional
  work that tier requires, choosing a rollout mechanic and a rehearsed kill
  switch, writing go/no-go criteria and naming the one person who calls it,
  or running the post-launch review against the metric registered before
  launch. Produces a tier assignment, a workstream table where every skip is
  a recorded decision, a go/no-go record, and a closing readiness record
  naming where each gate was answered. Stand down for a reversible internal
  change with no customer-visible surface, for a routine release already
  covered by standing release process, and for the question of whether to
  build the thing at all; say in one sentence that the method was not
  applied and ship.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Launch readiness

A working method for putting a change in front of customers when being wrong
is expensive to undo. It exists because launches fail from mismatched
resourcing far more often than from bad execution: a minor feature draws a
six-week cross-functional campaign, or a major bet goes out as a Tuesday
message in a channel. Tier first. Everything else is scoped to the tier.

Every step below is mandatory when this skill is engaged. The launch is not
approved until its readiness record is complete.

## 1. Scope, and when to stand down

Engage when a change reaches people outside the team and the cost of getting
it wrong is not trivially reversible: a new product or market, a
customer-visible feature, a pricing or terms change, a migration users will
feel, a general-availability step from beta.

Stand down when none of that holds. An internal-only change behind a flag, a
bug fix inside a standing release train, a copy correction, a change whose
rollback is one deploy and whose blast radius is one screen: these ship under
the team's normal release process, and interposing launch ceremony on them
trains the organization to ignore launch ceremony where it matters. Say in one
sentence that the launch method was not applied, name the tier you judged it
to be, and ship.

The prior decision of whether to build the thing at all is not in scope here.
If that decision is still open, this method is being used to avoid it.

## 2. Assign a tier before scheduling anything

Tier by actual blast radius and reversibility, never by how excited the team
is about the work. A well-loved feature with a one-line rollback is still a
tier 2 or tier 3.

| Tier | Definition | Lead time | Who signs off |
|---|---|---|---|
| Tier 1 | New product or market, press-worthy, major revenue or brand exposure, or an irreversible change to pricing, terms, or data | 4 to 6 weeks of preparation | A named executive calls go/no-go |
| Tier 2 | A meaningful change to an existing product that customers will notice, reversible within hours | 1 to 2 weeks of preparation | Product lead and engineering lead jointly, one named as tiebreaker |
| Tier 3 | Minor, low risk, incremental, reversible in one step | Release notes only, no dedicated launch process | The engineering lead ships it |

Write the assignment in exactly this shape:

```
Tier assignment: <launch name>
- Tier:            <1 | 2 | 3>
- Blast radius:    <who is affected, and how many>
- Reversibility:   <what undoes it, and how long that takes>
- Irreversible parts: <data migration, pricing change, public commitment, or none>
- Decider:         <person or role who calls go/no-go>
- Re-tier trigger: <the scope change that would move this up a tier>
```

Re-tier when scope changes mid-build. A launch that grows from tier 3
to tier 1 without picking up the process that comes with it is the most common
version of this method failing while appearing to be followed.

## 3. Scope the cross-functional work to the tier

| Workstream | Tier 1 | Tier 2 | Tier 3 |
|---|---|---|---|
| Sales enablement | Deck, battlecard, live training | One-pager | Not required |
| Support readiness | Full runbook, escalation path staffed | Updated help documentation | Release note |
| Legal and privacy | Required, early, before build completes | Required if data handling or terms are touched | Skip unless triggered |
| Marketing | Campaign, press, launch page | Announcement post | Skip |
| Pricing and billing | Explicit sign-off if pricing changes | Sign-off if touched | Skip unless touched |
| Localization | Complete, ahead of launch | Where markets are live | Skip unless customer-facing text changes |
| Security review | Required | Required if new attack surface | Standard code review suffices |
| Data and instrumentation | Metric registered and firing in a pre-production environment | Metric registered and firing | Skip |

Treat "not required at this tier" as a decision rather than an oversight.
Every skipped workstream is written down with who decided and why, so it is a
choice on record rather than a gap discovered later in an incident review.

**Capability honesty.** Where a workstream has a specialist owner (security,
legal, support, localization, billing), hand it to that owner and hold the
launch on their answer. Where no owner exists in this organization, run the
check yourself, say so, and record the line as `unreviewed by a specialist`.
Never record a specialist sign-off that no specialist gave.

## 4. Choose the rollout mechanic, not just the launch date

Exposure increases in this order: dark launch (code live, traffic off), then
internal dogfood, then a percentage ramp to real users, then beta with named
opt-in users, then general availability. Tier 1 and most tier 2 launches pass
through at least dogfood and a percentage ramp. Going straight to full
exposure is how a tier 1 failure becomes a tier 1 incident.

Every rollout needs a kill switch decided before launch rather than designed
during the incident. Write it in this shape:

```
Kill switch: <launch name>
- What flips:      <the specific flag, config, or deploy>
- Who can flip it: <named people or on-call role, with access confirmed>
- Time to effect:  <how long from decision to users unaffected>
- Rehearsed:       <yes, on date | no, and why not>
- Data cleanup:    <what stays broken after rollback, and who owns it, or none>
```

A rollback plan that exists only as an assumption ("we would just revert the
deploy") and has never been exercised is a finding to surface before launch,
not after. If there is no way to turn the change off, that is itself the
finding, and it changes the tier.

## 5. Set go/no-go criteria and name the decider before launch week

One person makes the call, named by name or role, never "the team." Criteria
are written before launch week, because deciding criteria inside the go/no-go
meeting is the same failure as writing requirements after the build started:
the pressure of the room replaces the judgment the criteria existed to supply.

Each criterion states what must be true, how it is observed, and what a red
result triggers: delay, roll back, or ship with a named mitigation. The
decision is recorded in exactly this shape:

```
Go/no-go record: <launch name>
- Tier:       <1 | 2 | 3>
- Decider:    <name or role>
- Decision:   <go | go with mitigations | delay | no-go>
- Criteria:
  - <criterion>: <green | red>, observed via <where>, red triggers <action>
  - <criterion>: <green | red>, observed via <where>, red triggers <action>
- Skipped workstreams: <workstream, decided by, why> | none
- Kill switch:  rehearsed <yes | no> | time to effect <duration>
- Metric registered: <the success metric, its baseline, and the review date>
- Dissent:    <the strongest stated objection and who raised it> | none raised
- Conditions: <what must be true after launch for this to stay a go> | none
```

A go recorded with no dissent line and no conditions is usually a meeting that
did not happen rather than a launch with no risk. Ask for the objection
explicitly before closing the record.

## 6. Run the post-launch review against the pre-registered metric

The review window is 30 to 90 days by tier: shorter for tier 2, the fuller
window for tier 1 where novelty effects need time to wash out. Compare against
the success metric registered before launch, never a metric redefined
afterwards to match whatever happened. Where the pre-registered metric turns
out to have been the wrong one, say that as a finding rather than
substituting a better-looking number.

The review forces one of three decisions and says which: iterate, hold, or
roll back. A review that reports numbers without landing on one of those three
is a status update wearing a review's clothes, and it is not done.

Name what would have been visible earlier. If the outcome was predictable from
something known before launch, that observation belongs in the review whether
or not anyone raised it at the time, and it is the only part of the review
that improves the next launch.

## 7. The closing gates

Before a launch is approved, each gate below is answered in the launch
document itself. This is work shown, not work claimed.

1. **Tier assigned**: the tier block, with blast radius, reversibility, and
   the re-tier trigger (section 2).
2. **Workstreams scoped**: the tier's required work named, with every skip
   recorded as a decision and its decider (section 3).
3. **Specialist coverage**: each specialist workstream either signed off by
   its owner or marked `unreviewed by a specialist` (section 3).
4. **Rollout mechanic**: the exposure sequence chosen, and why anything
   earlier in the order was skipped (section 4).
5. **Kill switch**: the kill switch block, including whether it was rehearsed
   (section 4).
6. **Criteria pre-written**: the go/no-go criteria existed before launch week
   and each names its red trigger (section 5).
7. **Decider named**: one person or role, not a group (section 5).
8. **Metric registered**: the success metric, its baseline, and the review
   date, all fixed before launch (section 5).
9. **Dissent recorded**: the strongest objection in its own words, or an
   explicit statement that it was asked for and none was raised (section 5).
10. **Pre-mortem**: assume the launch went out and failed badly; tell the
    most likely story of how, in a short labeled paragraph.
11. **Review scheduled**: the post-launch review date and owner exist before
    launch, not after (section 6).

## 8. The readiness record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 9. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The tier block, the
go/no-go record, the gates, and the readiness record are obligations on the
people running the launch, made checkable for a reader, and that visibility is
the enforcement tier this skill carries everywhere it goes. An environment that
separately gates deploys on a checklist adds a deterministic tier on top; this
file works identically with or without one, and never claims a tier it is not
running under.

## References

Where this method comes from: [references/sources.md](references/sources.md).

## When NOT to use

The stand-down conditions are in section 1 and take precedence over everything
else here. Beyond those, neighbouring skills own adjacent problems and this
skill defers to them where they are present: designing what the success metric
should be is metric design, and this method assumes a metric already exists and
gates against it; writing the launch narrative, press release, or requirements
for the thing being launched is requirements structuring; deciding whether to
build it at all is a strategy and decision-framing problem; and turning the
launch into evidence for a performance review afterwards is impact
measurement, a different audience from the post-launch product review in
section 6. None of those skills is required for this one to work, and this
file is complete on its own if none of them is present.
