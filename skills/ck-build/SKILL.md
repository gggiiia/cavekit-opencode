---
description: |
  Build against SPEC.md — plan-then-execute per task.
  Trigger: "build next task", "implement spec", "build task", "run build".
---

## ck-build — plan-execute loop

You are running the build skill. Read `SPEC.md`. Read `FORMAT.md` if not loaded.

Dispatch on intent:
- **Single task** → plan respecting cited §V/§I, execute, verify.
- **Next task** → lowest-numbered `.` or `~` row.
- **All tasks** → every `.` row in §T order.

Per task:
1. Flip status `.` → `~` in SPEC.md.
2. Edit code per plan.
3. Run verification command.
4. Pass → flip `~` → `x`. Fail → backprop.

On failure: classify (code bug / spec wrong / edge case). If spec-related, backprop via /ck-spec then resume. Never silently fix without considering §B.

Write policy: only flip §T status. No other edits to SPEC.md.
