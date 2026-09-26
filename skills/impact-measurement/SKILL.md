---
name: impact-measurement
description: >-
  Use when your own work has to become evidence a skeptic can check: a
  self-review, promotion packet, calibration submission, stakeholder or
  board update, a running brag log, or reconstructing what you actually
  delivered last quarter after the fact with no instrumentation in place.
  Covers calibrating to the real rubric, retroactive reconstruction from
  records kept without you in mind, one literal evidence-line format
  carrying claim, baseline, result, source and contribution level, honest
  attribution across many contributors, quantifying prevented cost and
  changed decisions without inventing precision, evidencing cancelled work,
  and a closing evidence record naming where each gate was answered. Stand
  down when designing product or business metrics, when the ask is a short
  status note nobody will weigh, or when the period is still open and the
  right action is one log line a week; say so in one sentence and answer
  directly.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Impact measurement

A working method for turning work you did into evidence that survives a reader
who has never met you and has reason to discount you. It exists because the
claim that survives a calibration room is not the impressive one. It is the one
a skeptic can check without talking to you. Optimize for checkability first and
magnitude second, because one number with an undefendable method discounts
every other claim in the document.

Every step below is mandatory when this skill is engaged, and the packet is a
draft until its evidence record is complete.

## 1. Scope, and when to stand down

Engage when your work will be weighed by someone with the power to say no and
the option to say "not yet": a performance review, a promotion packet, a
calibration submission, a stakeholder or board update where your team's
contribution is contested, or a reconstruction of a period you did not
instrument while living it.

Stand down when nothing is being weighed. Designing metrics for a product or a
business is a different problem with different rules. A short status note, a
stand-up summary, a message answering "what did you ship this week" needs an
answer, not an apparatus. And while the period is still open, the correct
practice is one log line a week (section 4), not this method run repeatedly:
measurement that displaces the work it measures is its own failure. Say in one
sentence that the evidence method was not applied, and answer directly.

Formal statistical claims are also out of scope. A packet narrative is not a
study, and dressing one as the other is the fastest way to lose both.

## 2. Calibrate to the actual rubric before writing anything

Generic impact is unwritable. Get the real material: the published level guide,
the calibration rubric, packets from your own organization that recently
succeeded at the level you are targeting, and the specific gaps your manager
has named. Extract three things:

- **The scope word for the next level.** Team, multi-team, organization,
  company. Every claim is written at that scope or it reads as strong
  performance at your current level, which is exactly how "not yet" is worded.
- **The two or three dimensions that actually decide it**, usually ambiguity
  handled, scope of influence, and business outcome. The rest is hygiene.
- **The counter-evidence they look for.** Most rubrics carry an implicit
  disqualifier: one large project and nothing else, or influence confined to
  your own team.

Write claims in the rubric's vocabulary, not yours. A reader scanning for
"drove alignment across organizations" will not translate your phrasing on your
behalf.

**Capability honesty.** Where the real rubric is not obtainable in this
environment, say so, name the substitute you used (a public level guide, a
manager's stated criteria), and mark the calibration line `[unverified]`.
Never present a packet as calibrated to a rubric you never read.

## 3. Separate what a manager needs from what a committee needs

These are two documents built from one evidence base. Confusing them is the
most common packet failure.

| | Your manager | A calibration committee |
|---|---|---|
| Knows | The context, the politics, what you were handed | Nothing; has never met you |
| Wants | Judgment, trajectory, where you needed support | Evidence mapped to rubric lines |
| Believes | Your narration, because they watched | Artefacts and named corroborators only |
| Right length | Short, with the hard parts named honestly | Dense, self-contained, no unexplained nouns |
| Fatal move | Polishing over a real problem they watched happen | A project name or acronym with no one-line stake |

For the committee, every project gets one sentence of business framing before
any detail: what it is, who it is for, what the company gets. Nobody will look
it up.

## 4. Reconstruct retroactively when you did not instrument

This is the normal case, not a failure. Rebuild from systems that recorded you
without being asked, in this order:

1. **Calendar, whole period.** The only honest record of where your time went,
   and it surfaces the recurring meeting you ran for six months and forgot.
2. **Your own writing.** Documents authored or commented on, decision memos,
   tickets filed or closed, code review history, the messages you sent in the
   weeks around each launch.
3. **Dashboards and their history.** Find the metric's value at the start and
   the end of the period before deciding what to claim. Capture a fixed date
   range; a live view moves under you and under your reader.
4. **Other people's records.** Retrospectives, incident reviews, quarterly
   business reviews, launch announcements. Being named in someone else's record
   is stronger evidence than anything you write about yourself.

Then build a chronology: date, what you did, what changed, where the proof
lives. Contradictions surface on their own, including the flattering ones you
would otherwise have overclaimed. A metric that moved before your change
shipped is not yours.

During an open period, the whole practice is one line a week: date, what
changed, the link. Five minutes weekly replaces a quarterly archaeology dig
and, more importantly, captures links before the dashboard, the channel, or
the person leaves.

## 5. The evidence line

Every load-bearing claim is written in exactly this shape, one line per claim,
before any of it becomes prose:

```
Claim:        <what changed, at the rubric's scope word>
Baseline:     <the before value, its date, and how it was obtained> | none recoverable: <why>
Result:       <the after value, its date, same instrument as the baseline>
Method:       <measured | reconstructed | reasoned estimate>: <the method in one clause>
Source:       <level 1-5 below>: <the specific link, document, or person>
Contribution: <led | drove | contributed | influenced>: <the counterfactual in one clause>
Confounds:    <what else could have moved this> | none identified
```

Source strength, strongest first. This is the ladder the `Source` field names:

1. A query or fixed-date-range view anyone can rerun and get your number from.
2. A dated document carrying your name, in the company's own system, unedited
   since.
3. Someone else's record naming you: a launch post, an incident review, an
   executive deck, a customer message.
4. A named corroborator who will say the same thing when asked and knows you
   are citing them.
5. Your own retrospective description. This is a claim, not evidence.

Every load-bearing claim carries at least a level 3. A claim resting only on
level 5 is either downgraded in language until it is honest, or the source is
obtained before the period closes.

When a baseline is unrecoverable, say so on the line and give the
absolute result plus the best directional evidence: "no clean baseline; tickets
on this flow ran near 40 a week across the three weeks before and near 9 a week
after, from the same saved query" is credible. A reconstructed percentage with
no stated method is not.

## 6. Attribution when a dozen people touched it

Pick the true verb and stay with it. Overclaiming is discovered exactly once,
and it retroactively discounts everything else in the document.

| Verb | Means | Proof it requires |
|---|---|---|
| Led | You owned the outcome and the decisions | You are named as owner in the record |
| Drove | You made it happen without formal authority | The specific thing that would not otherwise have happened |
| Contributed | You did a defined part of a larger thing | Your part, sized honestly |
| Influenced | You changed what someone else decided | The before state, and ideally their words |

Two rules make attribution survive a hostile read.

**Name the counterfactual, not the share.** "Without the migration plan I
wrote, the cutover would have needed a second freeze window" beats "I did forty
percent of the migration," which invites arithmetic nobody can settle.

**Credit generously and specifically.** A packet that names collaborators reads
as more senior than one that does not, and your named collaborators are exactly
the people asked to corroborate you.

Where several people can claim the same win, align before the cycle rather than
during it. Two packets claiming one outcome damages both.

## 7. Prevented cost and changed decisions

The most valuable senior work often leaves no metric, because the bad thing
did not happen. Make it checkable by evidencing the decision rather than the
imagined outcome.

- **State the counterfactual as a documented alternative, not a hypothetical.**
  "The plan of record was to build X for two quarters; my analysis changed it to
  Y" is verifiable from the document. "I saved two quarters of engineering" is
  not.
- **Anchor any sizing to a real internal price**: the team's own loaded cost per
  engineer, a vendor quote, the actual cost of the last comparable incident. Say
  which anchor you used, on the line.
- **Give a range at one significant figure with the assumption attached.**
  "Roughly one to two quarters of a four-person team, assuming the original
  scope estimate held." Precision you cannot defend reads as fabrication and
  discounts the whole claim.
- **Label it reasoned, not measured**, in the evidence line's `Method` field. An
  explicitly reasoned estimate is accepted. The same number presented as
  measured is challenged and lost.
- For risk avoided, evidence the exposure and the control: what could have
  happened, how you learned it could, what changed as a result. Skip
  probability-times-cost theater.

## 8. Work that failed or was cancelled

Cancelled work is a rubric answer, not a gap. It is the cleanest available
evidence of judgment under ambiguity, and senior rubrics look for it.

Write it in this order: the bet and why it was reasonable given what was known,
the signal you caught, when you caught it relative to when it was catchable,
what you recommended, what the company saved or learned, and what you changed
in how the team decides. Killing your own project early, in writing, with the
data, is a stronger senior signal than a mid-sized launch.

Never bury it, and never let it surface first from someone else. A known
failure you frame is evidence. The same failure omitted is a credibility
problem covering the entire packet.

## 9. The closing gates

Before a packet is submitted, each gate below is answered in the packet or its
appendix. This is work shown, not work claimed.

1. **Calibrated**: the real rubric obtained (or the substitute marked
   `[unverified]`), and the scope word named (section 2).
2. **Audience separated**: the manager document and the committee document are
   distinct, from one evidence base (section 3).
3. **Chronology built**: reconstruction ran across all four record types, and
   contradictions found are stated (section 4).
4. **Evidence lines complete**: every load-bearing claim carries the full line,
   including baseline or an explicit "none recoverable" (section 5).
5. **Sources at level 3 or better**: every load-bearing claim, with claims
   resting on level 5 downgraded in language (section 5).
6. **Verbs true**: each claim's contribution verb matches the proof it requires
   (section 6).
7. **Estimates labeled**: every prevented cost or changed decision is labeled
   reasoned, ranged, and anchored to a named price (section 7).
8. **Failures included**: cancelled or failed work is present and framed, or
   the packet states explicitly that the period contained none (section 8).
9. **Overclaim check**: the strongest argument that you are overclaiming,
   stated in its own words, and what in the packet answers it.
10. **Corroborators notified**: everyone named as a corroborator knows they are
    cited and will say the same thing.

## 10. The evidence record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 11. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The evidence lines, the
gates, and the record are obligations on you, made checkable for a reader, and
that visibility is the enforcement tier this skill carries everywhere it goes.
An environment that separately checks the record's presence or the source levels
adds a deterministic tier on top; this file works identically with or without
one, and never claims a tier it is not running under.

## References

Where this method comes from: [references/sources.md](references/sources.md).

## When NOT to use

The stand-down conditions are in section 1 and take precedence over everything
else here. Beyond those, neighbouring skills own adjacent problems and this
skill defers to them where they are present: designing product or business
metrics is metric design, and this method is about evidencing your own work
against a rubric instead; drafting and shaping the final document per audience
is a written-voice problem that runs after this one; rendering the packet as a
finished deck or report is an output-quality problem; landing in a new
organization is org entry; and stress-testing a single load-bearing claim
before a committee sees it is adversarial review. None of those skills is
required for this one to work, and this file is complete on its own if none of
them is present.
