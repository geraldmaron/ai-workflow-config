# The diagnosis record

The deliverable ends with a short block, exactly this shape:

```
Diagnosis record
- Reproduced:        answered: see <where> ("<quoted fragment>") | not done: <reason>
- Whole error read:  answered: see <where> ("<quoted fragment>")
- What changed:      answered: see <where> ("<quoted fragment>") | never worked
- Hypotheses tested: answered: see <where> ("<quoted fragment>"), <n> refuted
- Symptom explained: answered: see <where> ("<quoted fragment>") | unexplained: <what>
- Measurement ruled out: answered: see <where> ("<quoted fragment>") | not applicable
- Fix proven both ways:  answered: see <where> ("<quoted fragment>") | unproven: <why>
- Hole closed:       answered: see <where> ("<quoted fragment>")
- Confidence:        high | medium | low, because <what would raise it>
```

A gate that was not done says `not done: <reason>` in its slot. It is never
deleted and never skipped silently. Until every line is filled in, the
diagnosis is labeled a draft, by you, in its first line.

The record is presence, not quality. A reader can check in seconds that each
gate was answered and where. Whether the surviving hypothesis is genuinely the
best one is judgment, and the record never claims to have automated it.

Two rules travel with this record wherever methods compose. When several
disciplines govern one deliverable, the one owning the deliverable's shape
produces the full record and every other contributes exactly one line to that
same block, its name then its verdict or a one-clause gate summary, never a
second full block, because stacked records are how ceremony buries content. And
every `see <where>` carries a short quoted fragment of what it points at, not a
bare location: a pointer that cannot quote its target is pointing at nothing,
and the fragment is what makes a well-formed empty answer visible to a reader
who can only check presence.
