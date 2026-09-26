---
name: org-entry
description: >-
  Use when entering a new company, team, or domain and the first months will
  be judged: a new leadership role, an inherited product, team, or roadmap,
  a reorg that hands you unfamiliar scope, or a first 30/60/90 plan.
  Classifies the situation before choosing a playbook (Watkins STARS),
  verifies the classification against evidence rather than the hiring
  narrative, maps where decisions actually get settled versus the org chart,
  selects early wins that fit the type, and closes on an entry record naming
  where each gate was answered. Stand down for a lateral move inside an org
  whose political map you already hold, for a short advisory engagement
  where you will never hold the authority the classification allocates, or
  for a technical system you only need to read; say in one sentence that
  the method was not applied and proceed.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Org entry

A working method for the first months in a system someone else built, where
you will be judged on outcomes before you understand the machine that produces
them. It exists because new leaders rarely fail on competence. They fail by
running the playbook for a situation they are not in: cutting hard in an org
that believes it is healthy, or building consensus in one that is burning.

Every step below is mandatory when this skill is engaged. The classification
is the load-bearing act, and the entry plan is a draft until its record is
complete.

## 1. Scope, and when to stand down

Engage when you are arriving with authority you have not yet earned and the
first ninety days will set what you can do afterwards: a new role, an
inherited product or team, a reorg that hands you unfamiliar scope, a domain
you now own and did not build.

Stand down when the situation does not grant or withhold authority in that
way. A lateral move inside an org whose decision map you already hold needs a
scope briefing, not a classification. A short interim or advisory engagement
never holds the authority STARS allocates, so the type is decoration. Reading
an unfamiliar technical system is a mapping problem, not an entry problem.
Applying this apparatus where it is not needed is a failure of this skill, not
a safe default: a method that always interposes teaches the reader to ignore
it. Say in one sentence that the entry method was not applied, and proceed.

If it is unclear whether you hold real authority here, ask the
person who hired you one question rather than guessing in either direction.

## 2. Classify with STARS before deciding anything

The five types differ in what the organization grants you, not in how hard
they are.

| Type | What is true | What you are granted | What kills you here |
|---|---|---|---|
| Start-up | Nothing exists yet, resources scarce | Wide latitude, no legacy | Structure too late, or too much too early |
| Turnaround | Everyone knows it is broken | Authority to cut, fast, unilaterally | Consulting instead of deciding |
| Accelerated growth | The product works, scaling breaks | Money and headcount | Hiring ahead of the system that manages them |
| Realignment | Success is recent, decline is not visible yet | Almost nothing; the org thinks it is fine | Announcing change before evidence |
| Sustaining success | Strong org, high bar | Trust you have not earned | Changing things to prove you are needed |

The classic and expensive error is treating a realignment as a turnaround. In
a turnaround the case is already made and speed is the asset. In a realignment
you must manufacture the felt need first, using evidence from outside yourself
(a customer, a competitor, a churn cohort, a board member), because your own
authority is precisely what is in question.

Portfolios are mixed. Classify each unit separately, and never run one tempo
across all of them.

Write the classification in exactly this shape, one block per unit, before any
plan exists:

```
STARS classification: <unit>
- Type:            <start-up | turnaround | accelerated growth | realignment | sustaining success>
- Evidence for:    <the two or three observations that put it here, each with where you saw it>
- Rival type:      <the next most plausible type, and the one observation that argues for it>
- What it grants:  <the authority this type actually gives you>
- Confidence:      <high | medium | low>: <what would change it>
- Re-check by:     <the reclassification trigger from section 8 that applies first>
```

A unit whose rival type is left blank has not been classified. It has been
labeled.

## 3. Verify the type against evidence, not the hiring narrative

The story told in interviews is the story the org wants to be true, and it is
told by the people whose decisions produced the situation. Check it against
records that were kept without you in mind:

- Unit economics across the last eight quarters, from the source system rather
  than the deck version.
- Attrition by team and by tenure, with what leavers said on the way out.
- The last three roadmap documents against what actually shipped. That gap is
  your real capacity signal and is usually larger than anyone will state.
- Whether your predecessor was promoted, moved sideways, or removed, and who
  decided. This single fact identifies the type faster than any interview.

**Capability honesty.** Where the environment gives you no access to a record
named above, say so in the classification block and mark that line
`[unverified]` with one sentence on what would settle it. Never narrate a
review of numbers you could not open. An entry plan built on a hiring
narrative you could not check is still deliverable; one that pretends to
verification it did not perform is not.

## 4. Map the real decision system

The org chart gives reporting lines, not decision rights. Treat the decision
map as the main output of month one, and write it in this shape:

```
Decision map: <unit or scope>
- Veto holders:      <who can stop a thing without owning it, and over what>
- Load-bearing:      <whose public backing makes a proposal safe for others to join>
- Trusted nodes:     <named regardless of title, from the question below>
- Where it settles:  <the room or thread where the call is actually made>
- Reaction metric:   <the number whose movement causes an unscheduled meeting>
- Unknown:           <what you could not determine, and who would know>
```

Four ways to fill it:

1. **Veto holders.** Legal, security, a founder, a top-billing sales leader,
   one staff engineer. They stop things without owning them, and they rarely
   appear on the chart as such.
2. **Load-bearing support.** Backing that makes a proposal safe for others to
   agree with in public is a different asset from approval.
3. **Trusted regardless of title.** Ask five people in unrelated teams who
   they check with before committing to something. The same two or three names
   recur; those are your real nodes.
4. **Where it actually gets settled.** Find the meeting before the meeting. If
   decisions arrive at the review already made, the earlier room is often a
   direct message thread or a weekly one-to-one.

Separately, find the metrics leadership reacts to as distinct from the ones it
publishes. Watch which number moving causes an unscheduled meeting. That is
the real objective function, and it is often not the one on the strategy
slide.

## 5. Audit what you inherited

Roadmap first, because it shows what the previous regime believed. Then team,
because it shows what can actually execute. Then product.

- **Per roadmap item:** who asked for it, what evidence exists, what breaks if
  it is cut. An item with no identifiable requester and no evidence is a
  candidate for your first visible decision.
- **Per senior person:** keep, develop, move, or exit, each with the date by
  which you must decide. Do not act on any of these yet (see section 7), and
  do not let the date slip either.
- **Product:** the top three complaint themes, the worst retention cohort, and
  what the last three launches actually moved. If nobody can answer the last
  one, that is itself a finding and belongs in the record.

## 6. Choose early wins that match the type

An early win is a change the organization already agrees is a win. Its purpose
is credibility, not value, so select for three properties: visible to the
people named in the decision map, achievable inside the window, and impossible
to attribute to someone else's prior work.

| Type | Right kind of early win | Window |
|---|---|---|
| Turnaround | A cut, a shutdown, a fix to the obvious wound | Weeks 2 to 6 |
| Realignment | An evidence artefact that makes the problem undeniable | Weeks 6 to 12; no action before it |
| Accelerated growth | Removing a bottleneck people already complain about | Weeks 4 to 8 |
| Start-up | The first thing shipped to a real user | As early as possible |
| Sustaining success | A small improvement to someone else's priority | Weeks 4 to 10 |

State the win as a single line: what changes, who sees it, by when, and which
person in the decision map is expected to notice.

## 7. The 30/60/90, shaped by type

The phases are constant. The boundaries move by type, and the plan is written
in this shape, with the type named at the top so a reader can check the shape
against the classification:

```
30/60/90 | <unit> | type: <STARS type>
- Day 30:  <what is diagnosed, decided, or learned by here>
- Day 60:  <what is presented, acted on, or in place by here>
- Day 90:  <what is true about the unit that was not true on day one>
- Early win: <the win, its audience, its window>
- Held back: <what you are deliberately not doing yet, and until when>
```

The boundaries by type:

- **Turnaround:** diagnose by day 14, decide by 30, act through 60, rebuild
  the team by 90. Slowness here reads as absence.
- **Realignment:** listen through 45, present evidence around 60, propose
  between 75 and 90. The first sixty days produce a case, not a plan.
- **Accelerated growth:** name the constraint by 30, operating cadence in
  place by 60, hire against the constraint rather than the loudest request
  by 90.
- **Start-up:** something in a real user's hands well before 30, the first
  structural commitment by 60, the second only if the first held.
- **Sustaining success:** 30 to learn the standard, 60 to meet it visibly, 90
  to name the one threat the current success is hiding.

Four restraints hold in every type except turnaround: no reorganization, title
change, or exit before day 45, because you do not yet know who is
load-bearing; no comparison to a previous employer in any meeting, because it
converts experience into arrogance in one sentence; no new tooling, ritual, or
template in month one, because each spends credibility you will need for a
real decision; and no accepting the inherited roadmap by silence, which means
saying what you are reviewing and by when, or owning it by default.

The fifth restraint holds everywhere: do not fix the thing you are best at
fixing merely because you can see it. That is a preference, not a diagnosis.

## 8. Reclassification triggers

Re-run section 2 immediately on any of these, and say in the record that you
did:

- Proposals get polite agreement and no movement. You called it a turnaround;
  it is a realignment and nobody believes there is a problem.
- People bring you decisions you expected them to make. You called it
  sustaining success; it is a turnaround with no working decision rights.
- Your early win landed and nothing changed in how people treat you. Wrong win
  or wrong audience: recheck the decision map.
- You keep discovering commitments you did not know existed. You are operating
  outside the real decision system, and the map is wrong rather than
  incomplete.

Entry is complete when you can predict how a decision will go before the
meeting and you are wrong less than a third of the time. Until then you are
still learning the system, whatever you have shipped. If that has not happened
by day 90, the gap is almost always the decision map, not effort.

## 9. The closing gates

Before an entry plan is acted on, each gate below is answered in the plan
itself. This is work shown, not work claimed.

1. **Classified**: a STARS block per unit, each with a named rival type
   (section 2).
2. **Verified against records**: the hiring narrative checked against
   records kept without you in mind, unreachable ones marked `[unverified]`
   (section 3).
3. **Decision map**: veto holders, load-bearing support, trusted nodes, where
   it settles, the reaction metric, and what is still unknown (section 4).
4. **Inheritance audited**: roadmap, senior people with decision dates, and
   the product's three themes (section 5).
5. **Early win selected**: the win, its audience, its window, and why it
   cannot be attributed elsewhere (section 6).
6. **Plan shaped by type**: the 30/60/90 block, with what is being held back
   and until when (section 7).
7. **Restraints stated**: which of the first-weeks restraints you are keeping
   and any you are deliberately breaking, with the reason.
8. **Reclassification triggers**: named, with what you will watch to see them
   (section 8).
9. **Pre-mortem**: assume the plan was followed and you were gone in six
   months; tell the most likely story of how, in a short labeled paragraph.

## 10. The entry record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 11. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The classification
block, the gates, and the record are obligations on you, made checkable for
the reader, and that visibility is the enforcement tier this skill carries
everywhere it goes. An environment that separately checks the record's
presence adds a deterministic tier on top; this file works identically with or
without one, and never claims a tier it is not running under.

## References

Where this method comes from: [references/sources.md](references/sources.md).

## When NOT to use

The stand-down conditions are in section 1 and take precedence over everything
else here. Beyond those, neighbouring skills own adjacent problems and this
skill defers to them where they are present: reading an unfamiliar codebase,
service, or technical system is context mapping; turning your first months
into a promotion case or stakeholder narrative is impact measurement; setting
direction once you are established and trusted is product strategy; and
reconstructing why a specific inherited decision was made is an archaeology
problem, not an entry problem. None of those skills is required for this one
to work, and this file is complete on its own if none of them is present.
