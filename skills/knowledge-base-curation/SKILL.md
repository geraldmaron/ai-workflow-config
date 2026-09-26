---
name: knowledge-base-curation
description: >-
  Use for the recurring judgment pass over a personal knowledge base:
  triaging stray and untitled files, checking active zones for content that
  has gone stale, catching a document filed in the wrong place. Produces a
  short checklist of proposed moves, each a one-line item a person checks
  off; nothing is executed by this method itself. Not for files a mechanical
  rule already sorts by type or age, not for a code repository, and not for
  restructuring the knowledge base's own layout. That is a decision made
  separately, before this method runs again.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Knowledge base curation

A personal knowledge base accumulates two kinds of mess a mechanical rule
cannot catch: files that landed in the wrong place because nobody decided
where they belonged, and files that were right when written and are
wrong now because the thing they describe shipped, died, or changed.
Sorting by file type or by age catches neither. This is the judgment layer:
what is this file, does it still earn its place, where does it actually
belong.

The method proposes; it never executes. A checked box from a person is the
only thing that ever triggers a move, and every proposed move is reversible
by construction. Nothing here is ever a proposal to delete.

## 1. Scope, and when to stand down

Engage this method as a recurring pass over a knowledge base that already has a
structure worth protecting: named zones for active work, a place inbound
material lands, a place for material that is no longer active but not worth
losing. The tell that a pass is due: stray files accumulating outside any
named zone, more than a few untitled notes, or a zone that has not been
opened in longer than the kind of work it holds should sit unread.

Stand down when there is nothing to propose. An empty result ("no
qualifying files this pass") is a correct, healthy outcome, not a failed
run, and it is stated as one line rather than manufactured proposals to look
useful. Stand down as well when the request is really about the knowledge base's own
structure (renaming zones, changing what a folder means), because that is
a decision a person makes about the map itself, separately, before this
method runs again against the new map.

## When NOT to use

For locations a mechanical rule already owns (a general inbox that files by
type, a download or capture folder that ages files out on a schedule),
propose changes to that rule instead of hand-curating what it already
handles. Code repositories are owned by their own version control and
conventions, not by this method. And this method is never a vehicle for
restructuring the knowledge base (moving whole zones, renaming the top-level layout),
because that changes what every future proposal is judged against; that
decision is made once, deliberately, outside this recurring pass.

## 2. Sweep the known stray zones

Three places catch nearly everything worth triaging:

- **The knowledge base root**, for anything that is not the knowledge base's own top-level
  index and not inside one of its named zones. A file sitting at the root
  six months after creation almost always means nobody decided where it
  belongs.
- **Untitled or default-named files anywhere**, regardless of which zone
  they sit in. A default filename is evidence nobody has looked at the file
  since it was created.
- **The inbox folder**, for anything that has sat there long enough that
  "just captured" no longer describes it.

Anything sitting at a folder level its neighbors say is wrong (a reference
document among daily notes, a daily note among long-lived references) is a
fourth catch, found by noticing the neighbors, not by a rule.

This sweep is cheap to run often and expensive to skip for long: a knowledge base
left unswept for months accumulates enough stray files that the fifteen-item
cap in §5 stops being able to clear the backlog in one pass, and a person
who sees the same overflowing inbox every time stops trusting the digest to
ever catch up. A short, frequent pass beats an occasional thorough one.

## 3. Judge by content, not by name

Open every candidate found in step 2. A file's name is a claim about its
contents, and the claim is frequently wrong or absent.

- An untitled or default-named file with real content gets a proposed name
  drawn from its first heading or its actual subject, and a proposed
  destination in the zone that content belongs to.
- An empty or near-empty shell (a note with a title and nothing else, a
  capture that never got filled in) gets proposed for a cold-storage
  archive, not for deletion. Reversibility is the safety model this method
  runs on: a move can be undone by moving the file back; a deletion cannot
  be undone by this method at all, which is why deletion is never proposed,
  regardless of how empty the file looks.

## 4. Stale-check the active zones

Content that was correct when written and is wrong now is harder to
find than a stray file, because it looks exactly like every other file in
its zone. Check by content, not by modification time:

- A project note for work that has since shipped or been abandoned is
  stale, whether or not anyone comes back to update it.
- A dated or periodic note whose window has closed and that nothing else
  currently references is a candidate to move out of the active zone.
- A guide or reference superseded by a newer one in the same zone is stale
  even if it was edited recently: recency of the edit is not the same as
  currency of the content.

The test in every case is the same one: does this file still describe
something true, still pending, or still relied on by something else in the
knowledge base? If the honest answer is no, it is a candidate for the digest; if the
answer is unclear, it is not a candidate, because uncertainty is not
evidence of staleness.

Modification time alone answers neither question. A guide edited last week
can still be superseded if a newer guide covers the same ground more
correctly; a project note untouched for a year can still be current if the
project itself is merely slow rather than dead. Read enough of the file to
judge which is true before proposing anything against it.

## 5. Write the digest

Every proposal is one checklist line, in exactly this shape, with paths
given relative to the knowledge base root, never as an absolute path, never
naming a specific machine:

```
- [ ] MOVE: "<path relative to knowledge base root>" -> "<path relative to knowledge base root>": <one-line reason>
```

A rename is a move within the same folder, in the same shape. Refer to
destinations by role when the exact path is not yet decided ("into the
zone this content belongs to," "into cold storage") and resolve to a
literal relative path wherever the destination is already clear enough to
name.

Hard cap: fifteen proposals per pass, highest-value first. A digest long
enough to feel like a chore gets ignored wholesale, which defeats the
method entirely. A shorter, well-chosen list gets acted on. If nothing in
this pass clears the bar, the digest is one line saying so; an empty digest
is a healthy knowledge base, not a failed pass.

A worked example, for a stray note and a stale project file found in the
same pass:

```
Curation digest
- [ ] MOVE: "Untitled 4.md" -> "Areas/Reading/Notes on distributed consensus.md": has real content, first heading names its actual subject
- [ ] MOVE: "Projects/Q1 vendor migration/plan.md" -> "Archive/Projects/Q1 vendor migration/plan.md": project shipped, note now describes a finished state
```

A proposal declined twice (left unchecked across two consecutive passes)
is not proposed a third time. Note it once in the digest's footer instead,
so the next pass knows it was already considered and rejected rather than
overlooked.

## 6. Stop

The method's own work ends when the digest is written. It does not move,
rename, or delete anything itself. A person reviews the checklist and checks
the lines they approve; a separate apply step, where one exists in this
environment, executes only the checked and not-yet-applied lines, marks
them applied, and logs what it did. Where no separate apply step exists,
the digest still stands as the complete proposal, and a person carries out
the checked lines by hand.

## 6a. Composition, if other methods are present

This method judges content and proposes moves; it does not decide the
knowledge base's own layout. Where a separate decision process for the knowledge base's
structure exists in this environment, a proposal that would actually change
what a zone means, not just move a file within the existing map, is
handed to that process instead of being written as a checklist line here.
And where committing changes inside the knowledge base is itself governed by a
separate method in this environment, an applied move that touches version
control follows that method's own commit shape; this method's job ends at
the checklist regardless. Both are conditional: this method produces a
usable digest on its own, with or without either being present.

## 7. Capability honesty

If this pass cannot actually open a candidate file's content (no read
access, a format nothing here can parse), it is not judged by name alone.
Say so on that file's line, propose nothing for it, and list it separately
as skipped with the reason, so the next pass knows it still needs a look
rather than assuming it was already cleared.

## 8. The closing gates

Before a digest is called final, each gate below is answered:

1. **Zones swept**: the knowledge base root, untitled files, and the inbox folder
   were checked this pass, or the deliverable says which were skipped and
   why (§2).
2. **Content judged**: every candidate was opened and judged by its actual
   content, not proposed on its filename alone (§3).
3. **Active zones stale-checked**: the active zones were checked for
   content that has gone stale, judged against whether it is still true or
   still pending (§4).
4. **Shape followed**: every proposal is the exact one-line checklist item
   from §5, with relative paths only.
5. **Cap respected**: the digest holds fifteen or fewer proposals,
   highest-value first, or states that nothing qualified.
6. **Nothing executed**: no move, rename, or deletion happened as part of
   producing the digest itself (§6).
7. **Skips stated**: any file that could not be opened or judged is listed
   as skipped with a reason, not silently dropped (§7).

## 9. The record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 10. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The sweep, the
content judgment, the one-line shape, and the cap are obligations on
whoever runs the pass, made checkable for the person reviewing the digest -
that visibility is the enforcement tier this method carries everywhere it
is used. The rule that only a checked box triggers a move is itself
unenforced by this file; whatever executes checked lines, where something
does, is a separate deterministic tier added on top, and this file works
identically with or without one, never claiming a tier it is not actually
running under.
