# Install cavekit for OpenCode

## One-liner

```sh
# Install commands globally (available in any project)
cp -r commands/* ~/.config/opencode/commands/

# Install skills globally
cp -r skills/* ~/.config/opencode/skills/

# Or per-project (replace ~/.config/opencode with .opencode in your project root)
cp -r commands/* .opencode/commands/
cp -r skills/* .opencode/skills/

# Copy AGENTS.md to your project root (optional, embeds backprop+caveman rules)
cp AGENTS.md /path/to/your/project/
```

## Using the install script

```sh
./install.sh                  # install globally
./install.sh /path/to/project # install per-project
```

## What you get

| File | Location | Purpose |
|------|----------|---------|
| `commands/ck-spec.md` | `~/.config/opencode/commands/` | `/ck-spec` — create/amend/backprop SPEC.md |
| `commands/ck-build.md` | `~/.config/opencode/commands/` | `/ck-build` — plan-execute against spec |
| `commands/ck-check.md` | `~/.config/opencode/commands/` | `/ck-check` — drift detection |
| `skills/ck-spec/SKILL.md` | `~/.config/opencode/skills/` | Auto-trigger on "write a spec" |
| `skills/ck-build/SKILL.md` | `~/.config/opencode/skills/` | Auto-trigger on "build next task" |
| `skills/ck-check/SKILL.md` | `~/.config/opencode/skills/` | Auto-trigger on "check spec drift" |
| `FORMAT.md` | project root | SPEC.md schema reference |
| `AGENTS.md` | project root | Backprop protocol + caveman encoding rules |

## Dependencies

- [caveman](https://github.com/JuliusBrussee/caveman) plugin for OpenCode (optional, recommended)
- OpenCode >= 1.15

## Uninstall

```sh
rm ~/.config/opencode/commands/ck-*.md
rm -rf ~/.config/opencode/skills/ck-*/
```
