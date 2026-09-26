---
name: product-strategy
description: >-
  Use when asked to write, review, or rescue a product strategy, and the
  document in play is really a list of initiatives or a restated goal ("grow
  revenue 20%", "become the platform of choice"). Fires on a where-to-play
  or bet-selection call, an annual planning cycle, an inherited strategy
  deck, or a board or executive ask for "our strategy." Produces a kernel: a
  falsifiable diagnosis naming one obstacle, a guiding policy carrying an
  explicit "we will not" clause against something currently funded, three to
  five coherent actions, the conditions that would have to be true, and a
  closing record naming where each gate was answered. Stand down when the
  obstacle is already named and agreed and the real problem is sequencing a
  quarter of known work, when the decision is already made and being
  executed, or when the situation is too new to diagnose credibly. Say the
  method was not applied and help with the actual problem instead.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Product strategy

A working method for the documents that carry the word strategy and none of the
substance. It exists because the default behavior of a capable model under
planning pressure is specific and bad: restate the goal in more ambitious
language, list the initiatives already funded, describe the market instead of
the position, and produce something no one can disagree with, because nothing
was given up.

The test is mechanical. If no obstacle is named and nothing was surrendered,
there is no strategy in the room yet, however much work went into the deck.

Every step below is mandatory when this skill is engaged. The gates are not
suggestions, and the kernel is a draft until its record is complete.

## 1. Scope, and when to stand down

Engage when a real allocation follows: money, headcount, or attention will move,
and a wrong direction costs a cycle or more. Writing a strategy, reviewing an
inherited one, choosing between bets, deciding where to play, preparing the
board or executive answer.

Stand down when the obstacle is already named and agreed and the actual missing
artifact is a sequenced roadmap. Stand down when the decision has been made and
funded and the ask is help executing it. Stand down when the situation is too
new to diagnose: a diagnosis written from three days of exposure is a guess in
kernel clothing. In each case, say in one sentence that the strategy method was
not applied and why, then do the thing actually needed.

Applying the full apparatus to a team that already knows its obstacle is a
failure of this skill, not a safe default. It costs a quarter and teaches the
room to route around the method next time.

If it is unclear whether the stakes warrant the method, ask one
question rather than guessing in either direction.

## 2. Name the artifact being asked for

Four things get called strategy. The conflation is upstream of most bad
strategy work, so settle it in the first exchange and write down the answer.

| Artifact | Answers | Failure when substituted for strategy |
|---|---|---|
| Vision | Where we are going over years | Inspiring, unfalsifiable, guides no choice |
| Strategy | Which problem we will overcome, and what we give up to do it | Absent; work stays unprioritized |
| Roadmap | What we are building now | Becomes a promise ledger nobody can change |
| Goals and OKRs | How we will know | Teams get targets with no approach |

State the answer in one line at the top of the deliverable, exactly this shape:

```
Artifact: strategy | vision | roadmap | goals
Asked for: <what the requester said>
Delivering: <what this document is>, because <one clause>
```

If the ask was strategy and the missing artifact is a roadmap, say so here and
stop. That sentence is the whole deliverable, and it is a good one.

## 3. Diagnose the inherited document before writing a replacement

You will usually inherit something. Naming the specific defect is what earns
permission to redo it, so score the existing document before proposing
anything. Six tells, each reported as defect plus consequence, never as a grade:

- **No stated obstacle.** Search for the thing standing in the way. If the only
  nouns are ambitions, it is a wishlist.
- **Goals dressed as strategy.** "Grow ARR 40 percent", "win enterprise", "be
  the leader in X" are scoreboards. Ask "by overcoming what?" and watch the room
  go quiet.
- **No causal story.** For each initiative, ask what must happen in the world
  for it to move the goal. Initiative to goal with no mechanism in between is
  hope.
- **No tradeoff.** Find the sentence naming what is being given up. If every
  segment, customer type, and channel is still in scope, no choice was made.
- **Incoherent actions.** Coherent actions share a mechanism. A wishlist shares
  a page. Check whether the initiatives reinforce each other or merely coexist.
- **Reversible-sign test.** Would a sane competitor state the opposite? "We will
  focus on quality and customer delight" fails. "We will be worse at breadth to
  be undeniable at one workflow" passes.

Each finding is written in exactly this shape, one line each:

```
[defect: <tell>] <what the document says> → <what it costs, concretely>
```

A defect line with no consequence clause is an opinion and does not count.

## 4. Write the diagnosis

One paragraph naming what is actually going on, in causal terms, with the crux
isolated. Constraints belong here, the real ones: distribution, unit economics,
a platform dependency, a sales motion that cannot sell this. Not the polite
ones.

Two disciplines make it a diagnosis rather than a description.

**Falsifiability.** Write the sentence that would prove it wrong. A diagnosis
nothing could falsify is a description of your market, and a description of your
market is not a diagnosis of your situation. Carry it literally:

```
Diagnosis: <one paragraph, causal, one crux>
Falsified by: <the observation that would show this is not the obstacle>
Evidence: <what supports it> [cited: <source>] | [unverified: <what would settle it>]
```

**Capability honesty.** Where the diagnosis rests on contested facts about the
market, competitors, or customers, those facts need evidence. If the environment
gives you no way to read outside material, say so plainly, mark the affected
claims `[unverified]` with the one thing that would settle each, and proceed.
Never narrate research that did not happen. Where a separate research method is
present, it governs how that evidence is gathered and cited; a confident kernel
on a wrong diagnosis is worse than no strategy.

## 5. Write the guiding policy

An approach to the obstacle, not an outcome. It should rule things out on its
face. Exactly this shape:

```
Because <diagnosis in one clause>, we will <approach>,
which means we will not <named, currently funded thing>.
```

The "will not" clause must reference something real that someone currently wants
to do and is currently resourced. A sacrifice nobody was asking for is not a
choice, it is a slogan. If you cannot name a funded thing to stop, the policy is
not yet a policy.

Then name the **source of advantage** the policy leans on. Why does this work
for you and not for the three competitors who could copy the initiative list
next week? Acceptable answers: a distribution asset, a data or workflow
position, a cost structure, an existing customer relationship, a regulatory or
integration position. "We will execute better" is not one, and neither is a
capability you would have to build first, unless building it is the strategy and
the actions say so.

```
Advantage: <asset or position>, durable because <why it is not copyable in a quarter>
```

## 6. Derive coherent actions

Three to five. Each traceable to the guiding policy, each reinforcing the
others. Then apply the removal test: take any one action out and check whether
the others get materially weaker. If they do not, these are parallel projects
with a shared cover page.

Resource concentration is where strategy becomes real. If the allocation is even
across all actions, nothing was chosen. Carry the actions in a table that forces
the allocation into the open:

| Action | Traces to policy via | Reinforces | Share of the constrained resource |
|---|---|---|---|
| <action> | <clause of the policy> | <which other actions, how> | <rough percentage and of what> |

Name the constrained resource explicitly: engineering capacity, leadership
attention, cash, a single scarce team. It is rarely all of them, and the honest
answer is usually one.

## 7. Run "what would have to be true"

For each major bet, invert the argument. Do not ask whether you believe it will
work. Ask what conditions would have to hold for this to be the right choice,
then sort them:

1. Conditions already known true, with the evidence named.
2. Conditions assumed, ranked by how badly the strategy breaks if false.
3. For the top one or two, the cheapest test that would move belief, its owner,
   and when it reports.

Exactly this shape, one line per condition:

```
[known] <condition> | evidence: <what>
[assumed] <condition> | breaks: <what fails if false> | test: <cheapest test> | owner: <role> | reports: <cycle>
```

This converts an argument about opinions into a short list of testable claims,
and it lets a dissenting stakeholder disagree with a specific condition rather
than with you. An assumed condition with no test and no owner is the line the
strategy will die on.

## 8. Write the anti-strategy line

State plainly, in the document, what this strategy makes you worse at, which
customers you are choosing not to serve well, and what you would need to see to
reverse the choice. Strategies without this line get re-expanded during
planning until they are a wishlist again, and the re-expansion never announces
itself.

```
Worse at: <capability or segment, named>
Not served well: <who>
Reverse if: <the observation that would justify reopening this>
```

## 9. The closing gates

Before the kernel is called final, each gate below is answered in the document
itself. This is work shown, not work claimed.

1. **Artifact named**: the header line from §2 is present, and the delivered
   artifact matches what the situation needs.
2. **Diagnosis falsifiable**: one obstacle, causal, with its falsifier written
   and its contested facts cited or marked `[unverified]` (§4).
3. **Policy excludes**: the "will not" clause names something currently funded
   that someone actively wants (§5).
4. **Advantage named**: a source of advantage that is not effort or intent (§5).
5. **Actions cohere**: three to five, and the removal test was actually run and
   its result stated (§6).
6. **Allocation stated**: the constrained resource named, the concentration
   uneven and visible (§6).
7. **Conditions tested**: every assumed load-bearing condition has a breakage
   consequence, a cheapest test, an owner, and a reporting cycle (§7).
8. **Anti-strategy stated**: worse at, not served, reverse if (§8).
9. **Objection stated**: the strongest argument against this kernel, in its own
   words, under its own heading, not paraphrased into weakness.
10. **Pre-mortem**: assume the strategy was adopted and failed. Tell the most
    likely story of how, in one labeled paragraph.

If nobody objects to anything in the finished document, a summary was written
rather than a strategy. Send it back.

## 10. The strategy record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 11. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The shapes, the gates,
and the record are obligations on you, made checkable for the reader. That
visibility is the enforcement tier this skill carries everywhere it goes. An
environment that separately validates the record's presence adds a deterministic
tier on top; this file works identically with or without one, and never claims a
tier it is not running under.

## When NOT to use

Not for investigating the market or a competitor before anything can be
diagnosed: where a research method is present, it feeds §4 and this skill
consumes its output. Not for stress-testing a single decision that is already
formed; where an adversarial review method is present, route there, and escalate
to it when the kernel goes to a board or when the tradeoff moves budget away
from a currently funded team, which is a one-way door dressed as a document. Not
for choosing the metrics that track the strategy, and not for the requirements
document that implements it; where those methods are present they take the
kernel as input. Where the deliverable is prose a stakeholder will read, a
written-voice method governs voice, if present. Every one of these neighbors is
optional. This file works standalone and never requires another skill.

Skip it entirely for a single-team quarter where the obstacle is known and
agreed and the real problem is sequencing, and in the first weeks of a new
situation, where the honest move is to build the map first.

Recurring failures worth naming: diagnosing the market instead of your position
in it; a policy so abstract every existing action still qualifies; a list of
good ideas presented as coherence; scope creep by consensus during planning;
editing last year's document, which preserves last year's diagnosis unexamined;
and treating a stated tradeoff as done when the budget and headcount never moved
to match it.

## References

Where this method comes from: [references/sources.md](references/sources.md).
