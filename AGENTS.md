# cavekit — spec-driven development

cavekit commands available: `/ck-spec`, `/ck-build`, `/ck-check`.

## FORMAT

SPEC.md lives at repo root. Sections: §G GOAL, §C CONSTRAINTS, §I INTERFACES, §V INVARIANTS, §T TASKS, §B BUGS. Reference `FORMAT.md` for full schema.

## BACKPROP PROTOCOL

When test fails during `/ck-build`:
1. Read failure.
2. Classify: code bug / spec wrong / edge case.
3. If spec wrong → `/ck-spec bug: <cause>` updates §V + §B.
4. If code bug → fix, re-run. No spec change.
5. Never silently fix root cause without considering §B entry.

## CAVEMAN ENCODING

Apply to all SPEC.md content: drop articles/filler, use fragments, preserve code verbatim.
Reference symbols from FORMAT.md (→, ∴, ∀, !, ⊥, ≠, ≤, ≥).

## COMMANDS

- `/ck-spec` — create/amend/backprop SPEC.md. Sole mutator.
- `/ck-build` — plan-execute against spec. Auto-backprops on failure.
- `/ck-check` — drift report. Read-only.
