# The readiness record

The launch document ends with a short block, exactly this shape:

```
Readiness record
- Tier assigned:      answered, see <where>  | tier: <1 | 2 | 3>
- Workstreams:        answered, see <where>  | skipped: <count, each with a decider>
- Specialist cover:   answered, see <where>  | unreviewed: <list | none>
- Rollout mechanic:   answered, see <where>
- Kill switch:        answered, see <where>  | rehearsed: <yes | no>
- Criteria:           answered, see <where>  | written before launch week: <yes | no>
- Decider:            answered, see <where>  | <name or role>
- Metric registered:  answered, see <where>  | baseline: <value and date fixed>
- Dissent:            answered, see <where>  | none raised, asked for on <where>
- Pre-mortem:         answered, see <where>
- Review scheduled:   answered, see <where>  | owner: <name or role>
```

A gate that was not done says `not done: <reason>` in its slot. It is never
deleted and never skipped silently. Until every line is filled in, the launch
document is labeled a draft, by you, in its title line, and a draft is not a
go.

The record is presence, not quality: a reader can check in seconds that each
gate was answered and where, and that is all it proves. Whether the criteria
are the right criteria is judgment, and the record never claims to have
automated it.

Two rules travel with this record wherever skills compose. When several skills
govern one deliverable, the skill that owns the deliverable's shape produces
its full record, and every other skill contributes exactly one line to that
same block, its name and its verdict or a one-clause gate summary, never a
second full block, because stacked records are how ceremony buries content.
And every `see <where>` carries a short quoted fragment of what it points at,
not a bare location: a pointer that cannot quote its target is pointing at
nothing, and the fragment is what makes an empty answer visible to a reader
who can only check presence.
