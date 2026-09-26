# The record

The digest ends with a short block, exactly this shape:

```
Curation record
- Zones swept:          answered, see <where>
- Content judged:       answered, see <where>
- Active zones checked: answered, see <where>
- Shape followed:       answered, see <where>
- Cap respected:        answered, see <where> | proposal count: <n>
- Nothing executed:     answered, see <where>
- Skips stated:         answered, see <where> | none: no candidate was
  unreadable
```

A gate that was not done says `not done: <reason>` in its slot. It is never
deleted and never skipped silently.

When several skills govern one deliverable, the skill that owns the
deliverable's shape produces the full record above, and this skill
contributes exactly one line to that record: its name, then its verdict or
a one-clause gate summary, never a second full block. Every "see <where>"
in any record carries a short quoted fragment of what it points to, not a
bare location.
