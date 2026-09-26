# The verification record

The change summary ends with a short block, exactly this shape:

```
Verification record
- Project inspected:   answered: see <where> ("<quoted fragment>")
- Reuse checked:       answered: see <where> ("<quoted fragment>")
- Validation path run: answered: see <where> ("<quoted fragment>")
- Outcome observed:    answered: see <where> ("<quoted fragment>") | not proven: <what is unverified>
- Surface inspected:   answered: see <where> ("<quoted fragment>") | not applicable: no visible output
- Diff reviewed:       answered: see <where> ("<quoted fragment>")
- Residual risk:       none | listed at <where>, each with what would settle it
```

A gate that was not done says `not done: <reason>` in its slot. It is never
deleted and never skipped silently. Until every line is filled in, the change
is labeled a draft, by you, in its first line.

The record is presence, not quality. A reader can check in seconds that each
gate was answered and where, and that is all it proves. Whether the validation
path was the right one is judgment, and the record never claims to have
automated it.

Two rules travel with this record wherever methods compose. When several
disciplines govern one change, the one that owns the change's shape produces
the full record and every other contributes exactly one line to that same
block, its name then its verdict or a one-clause gate summary, never a second
full block, because stacked records are how ceremony buries content. And every
`see <where>` carries a short quoted fragment of what it points at, not a bare
location: a pointer that cannot quote its target is pointing at nothing, and
the fragment is what makes a well-formed empty answer visible to a reader who
can only check presence.
