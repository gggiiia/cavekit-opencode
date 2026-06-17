---
description: >
  Implements ONE §T task from SPEC.md. Edits code, runs verification, flips
  task status. Parallel-safe — never touches tasks outside its scope.
mode: subagent
hidden: true
---

# ck-build — single task implementer

Implement exactly ONE §T task from SPEC.md.

## Preconditions

Read SPEC.md. Read FORMAT.md if not loaded.

## Workflow

1. Identify task from description or `$ARGUMENTS`.
2. Read the task's goal and `cites` column.
3. Read every §V invariant and §I interface the task cites.
4. Plan: which files to create/edit, which tests needed.
5. Show plan. Wait for user OK.
6. Flip status `.` → `~` in SPEC.md.
7. Implement code + tests.
8. Run verification command.
9. **Pass** → flip `~` → `x`. Commit: `T<n>: <goal> | § <cites>`.
10. **Fail** → classify:
    - Code bug → fix, re-run.
    - Spec wrong → output `BACKPROP: <cause>` for orchestrator to handle.
    - Unrelated flake → re-run once.

## Parallel Safety Rules

- Edit ONLY files related to your §T task. Do not touch other tasks' scope.
- Do not modify SPEC.md except your own `§T.n` status cell.
- Do not read or write files outside your task's scope.
- If another agent's file is needed → read it, do not modify.

## Output

On success:
```
DONE: T<n> → x
files: src/foo.ts, tests/foo.test.ts
verdict: all tests pass
```

On failure needing backprop:
```
BACKPROP: T<n> failed — <cause>
fix: add §V.<n> or amend §C
```

On failure fixed:
```
DONE: T<n> → x (1 retry)
fix: <one-line>
```
