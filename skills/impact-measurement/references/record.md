# The evidence record

The packet ends with a short block, exactly this shape:

```
Evidence record
- Calibrated:        answered, see <where>  | scope word: <team | multi-team | org | company>
- Audience split:    answered, see <where>
- Chronology:        answered, see <where>  | contradictions found: <count | none>
- Evidence lines:    answered, see <where>  | claims: <count> | no baseline: <count>
- Source strength:   answered, see <where>  | below level 3: none | <which, and how downgraded>
- Verbs:             answered, see <where>  | led: <n> drove: <n> contributed: <n> influenced: <n>
- Estimates:         answered, see <where>  | anchors used: <which>
- Failures included: answered, see <where>  | none in period, stated at <where>
- Overclaim check:   answered, see <where>
- Corroborators:     answered, see <where>  | notified: <yes | pending, by when>
```

A gate that was not done says `not done: <reason>` in its slot. It is never
deleted and never skipped silently. Until every line is filled in, the packet is
labeled a draft, by you, in its title line.

The record is presence, not quality: a reader can check in seconds that each
gate was answered and where, and that is all it proves. Whether a claim is
written at the right scope is judgment, and the record never claims to have
automated it.

Two rules travel with this record wherever skills compose. When several skills
govern one deliverable, the skill that owns the deliverable's shape produces its
full record, and every other skill contributes exactly one line to that same
block, its name and its verdict or a one-clause gate summary, never a second
full block, because stacked records are how ceremony buries content. And every
`see <where>` carries a short quoted fragment of what it points at, not a bare
location: a pointer that cannot quote its target is pointing at nothing, and the
fragment is what makes an empty answer visible to a reader who can only check
presence.
