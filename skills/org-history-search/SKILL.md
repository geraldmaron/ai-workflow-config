---
name: org-history-search
description: >-
  Use when the answer to a work question is somewhere in a company's history
  but nobody wrote it down: why something was built this way, who really
  owns it, where a policy came from, what a lost thread decided, why a
  project was killed. Covers search operators, ticket and code archaeology,
  doc version history, calendar reconstruction, and asking a person so you
  get the real answer, closing in a filed finding with its evidence and any
  gap stated honestly. Not for a question a system of record answers
  directly (the tracker for status, the repository for behavior, the
  dashboard for a number). Go there first and skip this method entirely.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Institutional archaeology

Companies rarely document a decision; they leave traces of it. The decision
itself was made in a huddle, a direct message, or a hallway, and what survives
is the artifacts around it: a ticket that changed state, a doc whose scope
silently shrank, a meeting that appeared on four calendars two days before an
announcement. This method reconstructs from the traces, then verifies the
reconstruction against a system that would have had to change if the
reconstruction were true.

Every step below is mandatory when this method is engaged. A reconstruction
without its record is a guess wearing a citation's clothes.

## 1. Scope, and when to stand down

Engage this method when a question about a company's own history has no
single authoritative source and the answer matters: due diligence on an
inherited system, a decision someone wants to reverse or repeat, an ownership
question that will decide who gets paged, a policy nobody can explain, a
project's real cause of death. The tell is that the question starts with
"why" or "who really" and a direct lookup already failed to answer it.

Stand down when a system of record already holds the answer directly, or when
the question is small enough that guessing wrong costs nothing. Applying full
archaeology to a question a single dashboard settles is a failure of this
method, not a safe default: the reader learns to skip the ceremony next time.

If it is unclear whether the question needs reconstruction or
already has a direct answer, spend five minutes checking the obvious system
of record before starting the search below.

## When NOT to use

A system of record exists and is faster: the tracker for status, the
repository for current behavior, the dashboard for a number. Go there first.
Understanding how a system or product currently works, once found, is a
different method's job, not this one's. Investigating a question whose
answer lives outside the company is also a different method's job. This
method also never compiles information about a private person beyond what
the work question requires, and it does not decide who holds power on
arrival at a new organization. It recovers what happened, not who currently
matters.

## 2. Name the trace you're hunting

Each kind of decision leaves evidence in a different place, and searching the
wrong medium is why archaeology feels hopeless before it starts.

| Hunting | Look first | Tell that you've found it |
|---|---|---|
| A decision | The ticket state change, the doc revision, the announcement post | A dated statement of what will happen, from someone with authority to say it |
| Why it was built this way | The original proposal, the design doc's first version, the constraint recorded in the ticket | A constraint that no longer holds, still shaping the current state |
| The real owner | Who is paged, who approves the change, who answers questions about it now | Reviewer or approver of the last few changes, not a chart |
| A policy's origin | The first version of the policy document, the incident that preceded it | An incident review dated just before the policy appeared |
| Why it was killed | Shared calendars, headcount or budget changes, the planning document for that period | The budget or priority document, not a message someone remembers |

Before searching, write down what evidence would settle the question. A
search without that written down accepts the first plausible thing it finds.

## 3. Build a chronology, not a pile of hits

The single most useful move: order everything found by timestamp, not by
search relevance. Decisions leave a signature in time: a document edited
heavily on one day, a meeting the next, an announcement the day after, a
ticket closed at the end of the week. The chronology shows where the real
decision happened even when its content is missing from every individual
trace.

Anchor on the earliest known date and search outward in both directions.
Bracket every search by date rather than searching the whole history at once.

## 4. Search the workspace's own vocabulary

Zero results usually means the wrong vocabulary, not missing history. Every
organization accumulates codenames, internal abbreviations, a former product
name, a former team name. Find the local term first (channel names, pinned
messages, the ticket's own labels, an old slide deck), then search again with
it, plus the likely misspellings.

Search operators worth using deliberately:

```
in:#channel from:@person during:March          scope by room, author, month
before:2024-03-01 after:2024-02-01             bracket around the event
has:pin  has:link  has:reaction:white_check_mark   curated and resolved messages
"exact phrase"  -unrelatedword                 kill the noise term that dominates
in:@person                                     your own direct history with them
```

Search the words of the objection, not the words of the decision. Decisions
get announced in language nobody remembers; the argument that preceded them
is written in vivid, searchable words ("this will break billing," "we can't
ship this by the deadline"). Find the objection thread, then read forward to
what answered it.

Also search archived and renamed channels, and channels nobody currently on
the team would think to join. They are usually still searchable, and they
are frequently where the real argument happened.

## 5. Work the non-conversational layers

Real-time conversation is the noisiest layer and rarely the authoritative
one. In rough order of reliability:

- **Ticket history.** The change log, not the description. Who moved it to
  blocked and why, when priority changed, which larger effort it was pulled
  out of. A ticket closed "won't do" with a one-line comment names the
  decider and the date, which is most of what a reconstruction needs.
- **Code and change history.** A history search for when a symbol or string
  first appeared finds when a behavior was introduced; a rename-aware log
  survives file moves. Blame the line, read the change that introduced it,
  then read its review comments. That is usually where the real constraint
  is stated in someone else's words. A revert is a decision that reversed an
  earlier one, and its description normally says why.
- **Document version history.** Open the earliest version and diff it to the
  current one. The deleted paragraph is the finding: scope that got cut, a
  commitment that disappeared, sometimes the name of who removed it.
  Comment threads resolved long ago hold the actual debate.
- **Calendar reconstruction.** Search shared calendars in the window before
  the decision surfaced. A meeting titled with the project's name, an
  unusual attendee list, an unusually long block on an unusual day. The
  attendee list is the decision-maker set, and it is frequently the only
  surviving record of who was actually in the room.
- **Configuration, flags, and routing.** A feature flag left on for years, an
  alert-routing rule, an on-call rotation. These name real owners more
  accurately than any wiki page does.

## 6. Read the whole thread, then check what came after it

The message that matches a search is almost never the answer on its own, and
the specific failure mode is this: the decision was reversed three messages
later, or in a different room the next morning, or in a meeting that
produced no written trace at all.

- Never quote a thread read only from the top. Read to the end, including
  reactions: a checkmark from the owner is often the actual approval.
- After finding a decision, search the same terms across the following two
  weeks. A reversal reuses the vocabulary of the original.
- Check whether the person who stated the decision had the authority to make
  it. A confident, well-informed assertion from someone who was not the
  decider is the most common false positive in this kind of search.
- A thread that ends without resolution usually means the decision moved to
  a smaller, unrecorded conversation. Treat that silence as a pointer to
  look elsewhere, not as an answer.

## 7. Ask a person so you get the real answer

When the written record runs out, ask. How the question is asked determines
whether the answer is the official story or the real one.

- **Ask for the story, not the rationale.** "What was going on when you
  shipped that?" surfaces the constraint. "Why did you design it that way?"
  surfaces a defense of a decision already made.
- **Bring the trace you already found.** "I found a change from around that
  time, and the review mentions a constraint. Did that ever get resolved?"
  is specific, dated, and signals the work was already done, which is what
  makes people candid in return.
- **Offer the unflattering hypothesis first.** "I'm guessing this was a
  deadline thing rather than the intended design?" invites confirmation of a
  face-saving explanation nobody would volunteer unprompted.
- **Ask who disagreed.** "Who wasn't happy with that call?" finds the person
  who remembers the reasoning in the most detail, because losing an argument
  preserves memory better than winning one does.
- **Ask the person who left, not the one who owns it now.** They have no
  stake left in the current version of the story.
- **Never lead with "why doesn't this do X?"** It puts the other person in
  defense, and defensive answers are the official ones.

Treat every answer as one person's memory at one moment. Memory reliably
compresses timelines and converts accidents into intentions.

## 8. Verify against a system of record, then file the finding

A person's memory and a message thread are both claims, not proof. Before
relying on anything consequential, confirm it in the system that would have
had to change if the claim were true: the code, the configuration, the
contract, the tracker, the ledger. When the system and the thread disagree,
the system is what actually shipped, and that disagreement is itself part of
the finding.

Every recovered finding gets written in this exact shape before the work is
called done:

```
Finding: <what was recovered, in one sentence>
- Source:     <ticket / change / document / calendar / person>, with an
              identifier or link a reader can follow
- Date:       <what the source says, and what kind of date it is: when it
              happened, when it was recorded, or when it was last checked>
- Confirmed:  system of record | person who was present | both | unconfirmed
- Superseded: no | yes, see <where the reversal or later change is recorded>
```

Then file the finding where the next person will actually look for it (the
project's own documentation, a runbook, the originating ticket, a pinned
message), with links to the evidence and the date it was recovered. The next
person who needs this is often the same searcher, later, and the traces
decay: people leave, histories get trimmed, documents migrate.

## 9. Capability honesty

If this environment provides no way to search the workspace or its connected
systems, say so plainly rather than narrating a search that did not happen.
Hand back the exact queries a person with access should run (the operators,
the date brackets, the vocabulary from step 4), so the work is one search
away from resumable, and mark every affected finding `unconfirmed` in its
block rather than silently omitting the field.

## 10. The closing gates

Before a reconstruction is called final, each gate below is answered in the
deliverable itself:

1. **Trace named**: the evidence that would settle the question was written
   down before searching began (§2).
2. **Chronology built**: everything found is ordered by timestamp, and any
   remaining gap around the decision date is stated, not smoothed over (§3).
3. **Vocabulary checked**: the workspace's own terms, codenames, and former
   names were searched, not only the obvious phrasing (§4).
4. **Layers worked**: the non-conversational systems relevant to this
   question were checked, or the deliverable says which were skipped and why
   (§5).
5. **Thread read fully**: every quoted thread was read to its end, and the
   two weeks after any decision were checked for a reversal (§6).
6. **Person consulted**: someone with direct knowledge was asked, or the
   deliverable says why nobody could be reached (§7).
7. **System of record checked**: the finding was verified against a system
   that would have had to change, or the deliverable says verification was
   not possible and why (§8).
8. **Finding filed**: the finding was written in the shape at §8 and placed
   where the next person will look, or the deliverable says it could not be
   filed and why.

## 11. The record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 12. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The trace-naming
step, the chronology, the verification against a system of record, and the
closing record are obligations on whoever does the work, made checkable for
a reader. That visibility is the enforcement tier this method carries
everywhere it is used. An environment that separately checks the record's
presence adds a deterministic tier on top; this file works identically with
or without one, and never claims a tier it is not actually running under.
