# cavekit-opencode

Spec-driven development commands for OpenCode. Port of [cavekit v4](https://github.com/JuliusBrussee/cavekit) — compressed spec, plan-execute loop, drift detection.

**One spec to rule them all. Five agents. Parallel dispatch.**

## Commands

| Command | Job |
|---------|-----|
| `/ck-spec` | Create / amend / backprop `SPEC.md`. Sole mutator. |
| `/ck-build` | Plan-then-execute against spec. Auto-backprops on failure. |
| `/ck-check` | Read-only drift report. Lists §V / §I / §T violations. |

## Agents

### `@cavekit` (orchestrator)
Coordinates the full cycle — delegates to subagents, handles parallel dispatch.

### `@ck-spec`
Creates/amends/backprops SPEC.md. No code editing.

### `@ck-plan`
Reads §T dependency graph, outputs parallel build groups as JSON.

### `@ck-build`
Implements ONE §T task. Runs in parallel with other @ck-build instances for independent tasks.

### `@ck-check`
Drift detection — diffs SPEC.md against code. Read-only.

### Parallel flow

```
> @cavekit build a CLI that converts markdown to PDF

@cavekit → dispatches @ck-spec → SPEC.md created
        → shows spec, asks approval
        → dispatches @ck-plan → build groups
        → shows plan, asks approval
        → group 1: spawn @ck-build T1 + @ck-build T3 (PARALLEL)
            ├── T1 → implements → flips to x
            └── T3 → implements → flips to x
        → group 2: spawn @ck-build T2
            └── T2 → implements → flips to x
        → dispatches @ck-check → drift report
        → shows summary
```

## How it works

```
SPEC.md at repo root       ← durable artifact surviving context resets
├── §G GOAL                one-line intent
├── §C CONSTRAINTS          non-negotiable boundaries
├── §I INTERFACES           external surfaces (api, cmd, file, env)
├── §V INVARIANTS           numbered testable rules (! MUST hold)
├── §T TASKS                pipe table — x/~/. status
└── §B BUGS                 backprop log — bug → invariant

/ck-spec new     → creates SPEC.md
/ck-build        → reads §T, plans, edits, verifies
                 → failure triggers backprop → §B + §V update
/ck-check        → reads SPEC.md, diffs against code, reports drift
```

Every test failure becomes a §B entry. Classes of bug become §V invariants the spec never forgets.

## Install

### Via opencode.json (recommended)

```json
{
  "plugin": ["cavekit-opencode"]
}
```

The plugin auto-installs commands and skills into your opencode config on load.

**Prerequisite**: `npm install -g cavekit-opencode` or add to your project:

```sh
npm install cavekit-opencode   # project-level
npm install -g cavekit-opencode # global
```

### Manual install

```sh
git clone https://github.com/gggiiia/cavekit-opencode.git
cd cavekit-opencode
cp commands/ck-*.md ~/.config/opencode/commands/
cp -r skills/ck-* ~/.config/opencode/skills/
cp agents/*.md ~/.config/opencode/agents/
cp FORMAT.md /path/to/your/project/
```

Or use the install script: `bash install.sh [project-path]`

### Dependencies

- [caveman](https://github.com/JuliusBrussee/caveman) plugin for OpenCode (recommended)
- OpenCode >= 1.15

## Usage

### `@cavekit` orchestrator (recommended)

```
@cavekit build an auth service with JWT tokens
```

Agent creates SPEC.md, analyzes dependencies, parallelizes independent tasks, builds, and verifies. You approve at spec and plan stages.

### Direct subagent invocation

```
@ck-spec "auth service with JWT"
@ck-plan
@ck-build T1
@ck-check --all
```

### Slash commands (manual)

```
/ck-spec "auth service with JWT"
/ck-build --next
/ck-check --all
```

## Files

```
commands/
├── ck-spec.md           spec mutator
├── ck-build.md          plan-execute loop
└── ck-check.md          drift detector
skills/
├── ck-spec/SKILL.md     discovery-triggered spec
├── ck-build/SKILL.md    discovery-triggered build
└── ck-check/SKILL.md    discovery-triggered check
agents/
├── cavekit.md           @cavekit orchestrator — parallel cycle manager
├── ck-spec.md           @ck-spec — spec creation & backprop
├── ck-plan.md           @ck-plan — dependency analysis & build groups
├── ck-build.md          @ck-build — single-task implementation (parallel-safe)
└── ck-check.md          @ck-check — drift detection
FORMAT.md                SPEC.md schema + caveman encoding rules
AGENTS.md                always-on backprop protocol + encoding rules
install.sh               installer
```

## Why cavekit?

The spec is the only artifact that earns its tokens. Everything else that costs tokens must either save more tokens later, or the user's attention, or it gets cut.

- **Caveman encoding** — 75% fewer tokens than prose specs.
- **Backprop reflex** — test failures auto-commit as §B entries.
- **One file** — `cat SPEC.md` is the dashboard.

## License

MIT
