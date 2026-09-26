---
name: customer-discovery
description: >-
  Use when planning or running customer interviews, user research, or a
  continuous discovery program: validating a problem before committing to
  build, testing whether an assumption about users holds, standing up a
  weekly interview habit, recruiting churned or closed-lost or
  never-activated customers, or synthesizing a pile of interview notes into
  findings someone will fund. Covers question phrasing that survives
  politeness, opportunity solution trees, saturation per segment,
  cross-corpus tagging, and evidence strength labels. Produces tagged
  opportunities with disconfirming evidence recorded and a closing record
  naming where each gate was answered. Stand down when behavioral data
  already answers the question, when the decision is cheap and reversible
  behind a flag, or when leadership has already committed irreversibly and
  the research can only decorate it. Say the method was not applied and why.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Customer discovery

A working method for research whose findings will be spent: someone will build,
cut, or reprioritize because of them. It exists because discovery fails in two
predictable places, and both produce evidence-shaped material with no
information in it. The questions collect compliments about a future that does
not exist. The synthesis mines transcripts for quotes supporting the solution
someone had already chosen.

The default posture is continuous: a weekly touchpoint with customers, attended
by the product trio (product, design, engineering) together. Research sprints
are the escape hatch, not the norm, and a sprint whose findings arrive after the
decision was made is theater. Engineering attending is not a courtesy. Teams
that hear the pain firsthand stop relitigating it, which is most of the value.

Every step below is mandatory when this skill is engaged. The gates are not
suggestions, and a finding is a draft until its record is complete.

## 1. Scope, and when to stand down

Engage when a build, cut, or prioritization decision depends on whether a need
is real, what shape it has, or who has it, and being wrong costs a cycle or
customer goodwill.

Stand down in three situations. When behavioral data already answers the
question: if the logs show four percent complete the flow, interviews tell you
why, not whether, and the whether is settled. When the decision is
reversible and cheap to ship behind a flag, shipping is the cheaper instrument.
When leadership has committed irreversibly, discovery produces evidence nobody
can act on and burns customer goodwill for the appearance of rigor.

In each case say, in one sentence, that the discovery method was not applied and
why, then answer the actual question. Applying the full apparatus to a settled
question is a failure of this skill, not a safe default.

If it is unclear whether the stakes warrant the method, ask one
question rather than guessing in either direction.

## 2. Write the outcome and the assumption before recruiting anyone

Build the opportunity solution tree top down: one desired outcome, then
opportunities (unmet needs, pains, desires observed in interviews), then
solutions, then assumption tests. Interviews populate the opportunity layer
only. Interviewing to validate a solution already drawn is an assumption test,
not discovery, and it needs a different instrument (prototype, fake door,
concierge), not a conversation.

Carry the frame literally, before the first invitation goes out:

```
Outcome: <the one outcome this round serves>
Assumption at risk: <a behavioral claim, checkable in one interview>
Falsified by: <what a single interview could show that kills it>
Instrument: interview | prototype test | fake door | concierge | instrumentation
```

"Users want better reporting" is unfalsifiable and fails this block. "Operations
managers rebuild this report by hand every Monday and it takes over an hour" is
checkable in one conversation.

## 3. Recruit against survivorship, not availability

The default sample (friendly, engaged, available users introduced by an account
manager) systematically excludes everyone whose experience would change your
mind. Every round names its coverage across these segments, including the ones
it deliberately skipped:

| Segment | Why it changes conclusions | Where they are |
|---|---|---|
| Churned | The only people who can say what was actually intolerable | Exit list, 30 to 90 days out, with the account owner off the call |
| Closed-lost | Reveals the alternative that won and the real criteria | Pipeline records; get the stated loss reason, then verify it independently |
| Signed up, never activated | Where the promise and the product diverge | Product analytics cohort |
| Power users | Workarounds are unmet needs made visible | Usage percentile |
| Non-adopters in the target profile | Whether the problem is even top five for them | Cold outreach, community, event lists |

Recruit continuously with a standing slot (a recurring block plus an in-product
or email-based scheduler) rather than launching a push per project. Screen on
what they did last, never on who they are.

Coverage is stated in the deliverable in exactly this shape, one line per
segment, including zeros:

```
[segment: churned] n=<count> | reached via <how> | skipped because <reason, if n=0>
```

A segment silently absent is a claim the round makes without saying so.

## 4. Ask about past behavior, never about future intent

Talk about their life, not your idea. Anything about the future is a lie,
compliments are noise, and opinions cost the speaker nothing.

| Do not ask | Ask instead | Why |
|---|---|---|
| "Would you use a tool that does X?" | "Walk me through the last time you did X." | Hypotheticals measure politeness |
| "Do you think this is a good idea?" | "What have you tried to fix this?" | Opinions cost nothing |
| "How often does this happen?" | "When did it last happen? And before that?" | Frequency estimates are reconstructed |
| "Would you pay for this?" | "What are you spending on this today, in money, tools, or headcount?" | Stated willingness to pay is uncalibrated |
| "What features do you want?" | "What is the most frustrating part of this workflow?" | Users design badly and diagnose well |
| "Is this a big problem?" | "What happened as a result, the last time it went wrong?" | Severity shows in consequences |

Conduct rules with no exceptions:

- Ask about the last occurrence, then the one before it, to test any frequency
  claim against episodes rather than estimates.
- Chase specifics until you have a date, a tool name, or a number. An answer
  with none of the three has not landed yet.
- Redirect compliments once, plainly: "that is kind, tell me what you did last
  week instead." A second compliment on the same topic is a signal the topic is
  not real to them.
- Talk under a third of the time. Silence after an answer usually produces the
  real answer.
- Find the commitment: attention, a referral, budget, or a calendar slot.
  Enthusiasm that costs the speaker nothing predicts nothing.
- Take verbatim notes, not summaries. Your summary is where your bias enters the
  record, and it enters permanently.

**Capability honesty.** If the environment gives you no way to reach customers,
you have no interview capability on this task. Say so, mark every affected claim
`[unverified: no interview access]` with the one thing that would settle it, and
deliver the plan (frame, segments, question set) anyway. Never narrate an
interview that did not happen or a quote nobody said. A fabricated verbatim is
the single worst failure available in this method, because it is indistinguishable
from evidence downstream.

## 5. Volume and saturation

Interview weekly, indefinitely, rather than in fixed batches. Within a single
opportunity, patterns begin appearing around five or six interviews per distinct
segment, and the stopping point is **thematic saturation**: two or three
consecutive interviews in that segment produce no new theme, only repeats.

Saturation is per segment. Hitting it with enterprise administrators says
nothing about self-serve users, and a claim of saturation that does not name its
segment is not a claim.

Two things saturation never means. It is not prevalence: qualitative work
establishes that a need exists and what shape it has, never what share of the
base has it. Size it afterward with instrumentation or a survey. And it does not
survive a changed question: reframing the opportunity resets the count.

```
[saturation: <segment>] n=<count> | last <k> interviews added <n> new themes | claim: saturated / not saturated
```

## 6. Synthesize across the whole corpus before concluding

The discipline that prevents cherry-picking, in order:

1. Within a day of each interview, map it (experience map or discrete
   observations). Before the next one, or you will blend interviews from memory.
2. Extract every observation as an atomic note carrying its source, so any claim
   traces back to a person and a moment.
3. Tag themes across the **entire** corpus, including the interviews that
   contradict the emerging story. Tagging only the interviews you remember is
   how the pre-existing solution wins.
4. Place themes as opportunities on the tree. Separate need, pain, and desire
   from a requested solution: "add a bulk export button" is a solution, and the
   opportunity underneath is what they were going to do with the file.
5. Count supporting interviews per theme and record the disconfirming ones
   explicitly, with the segment they came from.
6. Label each finding with its evidence strength.

Three evidence labels, used exactly, on the same line as the finding:

- `[observed]`: behavior you or the instrumentation saw happen.
- `[reported]`: a specific past episode the person described, with a date, a
  tool, or a number attached.
- `[opinion]`: a preference, a prediction, or a generality.

`[opinion]` never supports a build decision on its own. A finding with no label
is treated as `[opinion]` by any reader who was not in the room, so label it.

Each finding is carried in exactly this shape:

```
[observed|reported|opinion] <finding, one sentence>
  supports: <n> interviews across <segments>
  disconfirms: <n> interviews, <segment>: <what they showed instead>
  sizing: unknown until instrumented | <measure that would size it>
```

A finding whose `disconfirms` line reads zero because nobody looked is not
disconfirmed. Say which it is.

## 7. The closing gates

Before findings are called final, each gate below is answered in the deliverable
itself. This is work shown, not work claimed.

1. **Frame stated**: outcome, assumption at risk, falsifier, instrument (§2).
2. **Instrument matched**: an interview is being used for an opportunity
   question, not to validate a drawn solution (§2).
3. **Coverage stated**: every segment line present, including zeros with their
   reason (§3).
4. **Questions behavioral**: the question set asks about past episodes, and any
   future-intent question in it is marked and justified (§4).
5. **Verbatims real**: every quote came from a conversation that happened, or
   the capability-honesty clause was invoked and the claims marked (§4).
6. **Saturation claimed per segment**: with counts, or explicitly not claimed
   (§5).
7. **Whole corpus tagged**: including the contradicting interviews (§6).
8. **Evidence labeled**: every finding carries `[observed]`, `[reported]`, or
   `[opinion]` (§6).
9. **Disconfirmation searched**: the leading opportunity has disconfirming
   evidence that was looked for, not merely absent (§6).
10. **Prevalence not implied**: no qualitative count is presented as a
    percentage of the base, and each finding names how it would be sized (§5).

## 8. The discovery record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 9. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The labels, the gates,
and the record are obligations on you, made checkable for the reader. That
visibility is the enforcement tier this skill carries everywhere it goes. An
environment that separately validates the labels or the record's presence adds a
deterministic tier on top; this file works identically with or without one, and
never claims a tier it is not running under.

## When NOT to use

Not for desk research on a market, a competitor, or a category, which has no
users to talk to: where an investigative research method is present, route
there. Not for defining or instrumenting the quantitative measures that size
what you found, and not for writing the requirements afterward: where those
methods are present, they consume these findings rather than produce them. When
a finding changes the diagnosis rather than the backlog, a strategy method owns
that, if present. When a finding is about to justify a multi-quarter build,
especially where the sample skewed friendly and saturation was claimed in one
segment, an adversarial review method is the right next step, if present. Where
the write-up is prose a stakeholder will read, a written-voice method governs
voice, if present. Every one of these neighbors is optional. This file works
standalone and never requires another skill.

Recurring failures worth naming: leading questions manufacturing enthusiasm and
then treating it as validation; interviewing only the available and the happy;
treating three interviews as proof; confusing what people say with what they do
when the analytics are right there; letting a stakeholder attend and pitch;
synthesizing from memory or from the two interviews that went well; reporting
qualitative counts as percentages; and running discovery after the roadmap is
locked.

## References

Where this method comes from: [references/sources.md](references/sources.md).
