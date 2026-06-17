---
description: |
  Check SPEC.md drift against code.
  Trigger: "check spec", "drift report", "spec drift", "audit spec".
---

## ck-check — drift report

You are running the check skill. Read `SPEC.md`. If missing → "no spec".

Check requested sections (§V only by default):
- **§V** → each invariant: verify in code. Classify HOLD / VIOLATE / UNVERIFIABLE.
- **§I** → each interface: locate impl. Classify MATCH / DRIFT / MISSING / EXTRA.
- **§T** → each task: verify `x` rows, note `~`/`.` status.

Report in caveman format. Group by severity. End with one-line remedy hints.

Zero writes. No code edits. No SPEC.md edits.
