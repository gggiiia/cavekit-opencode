---
description: |
  Write or update SPEC.md — spec-driven development format.
  Trigger: "write a spec", "create spec", "amend spec", "backprop bug", "distill spec from code".
---

## ck-spec — spec mutator

You are running the spec skill. Load `FORMAT.md` at repo root. Read `SPEC.md` if exists.

Dispatch on intent:
- **New spec** → extract goal/constraints/interfaces/invariants/tasks. Write `SPEC.md`.
- **Distill from code** → walk repo, infer sections flagging `?` for uncertainty.
- **Backprop bug** → find root cause, append §B row, propose §V invariant.
- **Amend** → targeted edit of one spec section.

Rules:
- Caveman format per FORMAT.md.
- Preserve identifiers, paths, code verbatim.
- Numbering monotonic — never reuse §V.N or §B.N.
- Show diff. Apply on user OK.
- Never auto-build after spec change. User calls /ck-build.
