# The record

The deliverable ends with a short block, exactly this shape:

```
Commit record
- Diff read:          answered, see <where>
- Scope single:       answered, see <where>
- No secrets:         answered, see <where> | found and flagged: <yes/no>
- Branch correct:     answered, see <where>
- Message shaped:     answered, see <where>
- Pull request shaped: answered, see <where> | not applicable: no pull
  request opened
- Push authorized:    answered, see <where>
```

A gate that was not done says `not done: <reason>` in its slot. It is never
deleted and never skipped silently.

When several skills govern one deliverable (a change that is also
load-bearing enough for a harder challenge before it merges, for instance),
the skill that owns the deliverable's shape produces the full record above,
and this skill contributes exactly one line to that record: its name, then
its verdict or a one-clause gate summary, never a second full block. Every
"see <where>" in any record carries a short quoted fragment of what it
points to, not a bare location.
