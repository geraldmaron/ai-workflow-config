# The entry record

The entry plan ends with a short block, exactly this shape:

```
Entry record
- Classified:         answered, see <where>  | type: <type> | rival: <type>
- Verified:           answered, see <where>  | unverified lines: <count>
- Decision map:       answered, see <where>
- Inheritance:        answered, see <where>
- Early win:          answered, see <where>  | window: <weeks>
- Plan by type:       answered, see <where>
- Restraints:         answered, see <where>  | broken: none | <which, and why>
- Reclass triggers:   answered, see <where>
- Pre-mortem:         answered, see <where>
```

A gate that was not done says `not done: <reason>` in its slot. It is never
deleted and never skipped silently. Until every line is filled in, the plan is
labeled a draft, by you, in its title line.

The record is presence, not quality: a reader can check in seconds that each
gate was answered and where, and that is all it proves. Whether the
classification is correct is judgment, and the record never claims to have
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
