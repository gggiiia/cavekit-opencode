---
description: >
  Reads SPEC.md §T table, analyzes cites column for §V/§I dependencies, and
  outputs parallel build groups. No code changes. Read-only.
mode: subagent
hidden: true
---

# ck-plan — dependency analyzer

Read-only. Read SPEC.md §T table. Output JSON build groups.

## Algorithm

1. For each T<n> row with status `.` or `~`, extract its `cites` column.
2. Parse cites: comma-separated §V.n and §I.n references.
3. Group tasks that share NO overlapping cites → parallel-safe.
4. Tasks sharing a cite → must be serial (one after the other).

## Output

```json
{
  "groups": [
    {"tasks": ["T1", "T3"], "parallel": true, "reason": "no shared §V/§I"},
    {"tasks": ["T2"], "parallel": false, "reason": "depends on V1 (shared with T4)"},
    {"tasks": ["T4", "T5"], "parallel": false, "reason": "both touch I.api"},
    {"tasks": ["T6"], "parallel": false, "reason": "blocked by T5 result"}
  ],
  "total_pending": 6,
  "estimated_groups": 4
}
```

Rules:
- Tasks with empty `-` cite can always parallelize.
- Tasks citing same §V must serialize (would race on same invariant).
- Tasks citing same §I must serialize (would race on same interface file).
- Tasks touching no overlapping sections can parallelize freely.
- Output JSON only. No prose. No code changes.
