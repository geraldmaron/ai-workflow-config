# The measurement record

The deliverable ends with a short block, exactly this shape:

```
Measurement record
- Value exchange:      answered, see <where>
- Output metric:       answered, see <where> | rejected: <candidate> fails <test>
- Frame:               answered, see <where> | frame: <which>
- Inputs:              answered, see <where> | count: <n> | dependency-free: <yes/no>
- Reconciliation:      answered, see <where> | gap: <n> percent | unreconciled: <why>
- Counter-metrics:     answered, see <where> | thresholds agreed: <n> of <n>
- Definitions:         answered, see <where> | terms undefined: <list or none>
- Key results:         answered, see <where> | baselines missing: <list or none>
- Instrumentation:     answered, see <where> | verified end to end: <yes/no>
- Gaming pass:         answered, see <where> | signatures found: <list or none>
```

A gate that was not done says `not done: <reason>` in its slot. It is never
deleted, never skipped silently. Until every line is filled in, the deliverable
is labeled a draft, by you, in its title line.

The record is presence, not quality. A reader can check in seconds that each
gate was answered and where, and that is all it proves. Whether the output
metric is the right proxy for value is judgment, and the record never claims to
have automated it.

Two rules travel with this record wherever skills compose. When several skills
govern one deliverable, the skill that owns the deliverable's shape produces its
full record, and every other skill contributes exactly one line to that same
block (its name, then its verdict or a one-clause gate summary), never a second
full block, because stacked records are how ceremony buries content. And every
"see <where>" carries a short quoted fragment of what it points at, not a bare
location. A pointer that cannot quote its target is pointing at nothing, and the
fragment is what makes an empty answer visible to a reader who can only check
presence.
