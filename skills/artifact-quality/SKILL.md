---
name: artifact-quality
description: >-
  Use when producing a finished document, PDF, deck, spreadsheet, or report
  that another person will read, before calling it done, including every
  chart and diagram inside it. Mandatory gates: a restrained design system
  chosen before styling anything, every chart and diagram checked against
  the data and the system it claims to depict, the rendered file opened and
  walked surface by surface with a per-surface inspection record, the
  furniture (numbering, captions, cross-references, contents) checked
  against the document it describes, and a closing record naming where each
  gate was answered. Not for drafts, working notes, or scratch output, not
  for drafting the prose itself, not for product artifacts whose shape is
  the question, and not for live interactive interfaces. Skip this method
  entirely for those.
license: Apache-2.0
metadata:
  version: 0.1.0
---

# Artifact quality

A working method for static exported deliverables: documents, PDFs, decks,
spreadsheets, printed and downloadable reports, and every chart and diagram
inside them. It exists because a file that generated without error reads as
finished, and the two defects that actually cost something are invisible from
the source: a page that broke where nobody looked, and a chart that overstates
the case and gets caught in the room.

The file is not the deliverable. The rendered file, seen, is the deliverable.
Every step below is mandatory when this skill is engaged, and the artifact is a
draft until its record is complete.

## 1. Scope, and when to stand down

Engage this method when the output is a finished static file another person
will read, present, forward, or act on, and when there is a rendering step
between the source and what that person sees.

Stand down for drafts, working notes, scratch output, intermediate results, and
conversational answers. Polish gates finished deliverables. Applying it to every
intermediate output slows iteration for no reader benefit, and a method that
always interposes teaches the reader to ignore it. When speed is explicitly
preferred over polish, say in one line what was skipped rather than polishing
anyway.

This method judges the artifact, never the content. Whether the words are right,
whether the argument holds, and whether the recommendation is sound are other
questions with other owners.

## When NOT to use

Drafts and scratch output. Drafting the prose itself, which is a voice and
structure question. Product artifacts whose shape is the open question, such as
a requirements document still deciding what it is. Live interactive interfaces,
which are verified by exercising them, not by walking pages. And source that
will never be rendered for a reader.

## 2. One design system, chosen once

A set of deliverables should read as one system rather than being restyled from
scratch each time. If an established template or pattern already exists for
this audience, use it and say so. Otherwise fix a minimal system before styling
anything, covering:

page or slide grid and margins; type hierarchy with a named size for each
level; a spacing scale; table styling; callouts and captions; citation form;
headers, footers, and numbering; diagram styling; contrast that survives
projection and print; and where source notes go.

Keep it restrained. Decoration is the first thing a hostile reader discounts
and the last thing that survives a photocopier. Consistency inside the document
matters more than the merit of any individual choice.

## 3. Charts and diagrams must be honest

The most expensive defect in a deck is not an ugly slide.

**Diagrams** must depict the system or proposal as it actually is. No
decorative boxes implying components, connections, failover, security
boundaries, or data flows that do not exist. Every diagram carries a title, a
stated scope, direction on flows where direction is meaningful, a legend where
the notation is not self-evident, and text readable at final rendered size.

**Charts** carry units, time period, and source on the chart itself. Do not
truncate or double an axis in a way that manufactures a trend. Do not show
precision the data does not support. Represent missing data as missing, never
as zero and never by silent interpolation. State the denominator, and keep it
consistent across compared series. If a four-row table communicates the result
better than a chart, use the table.

Each chart or diagram is checked in exactly this shape:

```
Figure:      <title, and where it appears>
Claim:       <what a reader will conclude from it in three seconds>
Data:        <source, period, units, denominator>
Axes/scope:  <ranges and baselines, or the boundary the diagram claims>
Missing:     <how absent data is shown> | none
Read-back:   <the numbers read off the rendered figure, not off the query>
Verdict:     honest | corrected: <what was changed> | unverified: <why>
```

A chart is not verified because the query behind it ran. Render the final
figure and read the values off it.

## 4. Render and inspect, every surface

Open the rendered output and walk every page, slide, or sheet. Not a sample,
not the ones that changed. Every one.

- **Integrity**: bad breaks, orphaned headings, content running off the
  surface, sections silently missing, blank surfaces.
- **Tables and figures**: split or broken tables, distorted or low-resolution
  images, text unreadable at final size, mislabeled figures.
- **Consistency**: spacing, hierarchy, and styling that drift between sections
  built at different moments.
- **Furniture**: numbering, headers, footers, captions, citations,
  cross-references, and the table of contents actually matching the document
  they describe.

Check the last surface as carefully as the first. Rendering defects concentrate
at the end, where attention does not.

The inspection is recorded per surface, in exactly this shape, one line per
surface or per contiguous clean range:

```
Inspection record
- p<n>-<n>:  clean
- p<n>:      <defect observed> -> fixed | accepted: <why it stands>
- p<n>:      <defect observed> -> fixed
Renderer:    <how the file was produced and opened>
Surfaces:    <n> of <n> inspected
```

A range may be marked clean only if every surface in it was actually seen.

**Capability honesty.** If this environment offers no way to render or open the
output, you have no inspection on this artifact. Say so in the deliverable,
name exactly what went unseen, state the residual risk, and mark the inspection
gate `not done`. Never describe a walkthrough that did not happen, and never
call an unrendered file polished.

## 5. Export fidelity, and what the medium changes

The rendered file is not the source, and the export step is where silent damage
happens. Before handover, confirm on the exported file itself:

- Fonts embedded or substituted knowingly, never substituted by surprise.
- Images at the resolution the medium needs, and not upscaled past their source.
- Links resolving, including cross-references and any table of contents.
- Text selectable and searchable where the medium supports it, rather than
  flattened into an image of text.
- File size proportionate to what it will travel through.
- No editing residue carried into the export: comments, tracked changes,
  speaker notes, hidden columns, stale filters, or off-canvas objects.

Three media change the work:

- **Decks** are read at distance and under bad light. Check the smallest text
  at projected size, and check that each slide survives being screenshotted out
  of sequence, because that is how they are forwarded.
- **Spreadsheets** are inspected by formula, not only by value. Check that
  numbers are values or intended formulas rather than pasted text, that units
  and precision are consistent down each column, that hidden rows and columns
  are hidden on purpose, and that a reader who sorts or filters will not break
  a relationship the layout implied.
- **Long reports** drift. Check the hierarchy at the halfway point against the
  first section, and check that anything numbered increments the way a reader
  expects.

## 6. The closing gates

Before the artifact is called done, each gate below is answered:

1. **Design system stated**, or the existing template named (§2).
2. **Every figure checked**, with a figure block each (§3).
3. **Every surface inspected**, with the per-surface record (§4).
4. **Furniture checked** against the document it describes (§4).
5. **Defects resolved**, each either fixed or accepted with a reason.
6. **Export checked** on the exported file, not the source (§5).
7. **Residual risk** stated, including anything deliberately left rough.

## 7. The quality record

Close the deliverable with the record in
[references/record.md](references/record.md). A gate that was not done says
`not done: <reason>` in its slot, and until every line is filled in, the
deliverable is labeled a draft in its title line.

## 8. Composition

Each of these engages only if that discipline is available here, and this
method works identically alone:

- A prose voice method owns the writing when the problem is the words rather
  than the render, if present.
- A requirements method owns the shape when the artifact is the wrong artifact,
  if present.
- A research method owns whether the underlying claims are true, if present.
  This method checks only that the figure depicts the data it cites.
- An adversarial review method owns the challenge when a figure carries a claim
  an outside audience will act on, such as a board, a customer, a regulator, or
  the press, if present. At that point the honesty of the visual is the
  decision, not the styling.
- Where brand, accessibility, or legal owns part of the review, hand that part
  over and integrate what comes back. Where nobody owns it, inspect it here and
  record it as unreviewed by a specialist rather than dropping it.

## 9. What is enforced, and by what

Nothing in this file is machine-enforced by this file. The figure blocks, the
per-surface inspection record, the gates, and the closing record are
obligations on you, made checkable for the reader, and that visibility is the
enforcement tier this method carries everywhere it goes. An environment that
separately compares rendered output against a reference, or that lints the
record's presence, adds a deterministic tier on top. This file works
identically with or without one, and never claims a tier it is not running
under.

## References

Where this method comes from: [references/sources.md](references/sources.md).
