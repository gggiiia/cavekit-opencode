#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-global}"

if [ "$TARGET" = "global" ]; then
  CMD_DIR="$HOME/.config/opencode/commands"
  SKILL_DIR="$HOME/.config/opencode/skills"
else
  CMD_DIR="$TARGET/.opencode/commands"
  SKILL_DIR="$TARGET/.opencode/skills"
fi

mkdir -p "$CMD_DIR" "$SKILL_DIR"

cp "$SCRIPT_DIR/commands/ck-spec.md"   "$CMD_DIR/"
cp "$SCRIPT_DIR/commands/ck-build.md"  "$CMD_DIR/"
cp "$SCRIPT_DIR/commands/ck-check.md"  "$CMD_DIR/"
cp -r "$SCRIPT_DIR/skills/ck-spec"     "$SKILL_DIR/"
cp -r "$SCRIPT_DIR/skills/ck-build"    "$SKILL_DIR/"
cp -r "$SCRIPT_DIR/skills/ck-check"    "$SKILL_DIR/"

echo "cavekit installed to:"
echo "  commands → $CMD_DIR/ck-*.md"
echo "  skills  → $SKILL_DIR/ck-*/"
echo ""
echo "Copy FORMAT.md and/or AGENTS.md to your project root as needed."
