#!/bin/sh

set -e

CODERELAY_DIR="$(cd "$(dirname "$0")" && pwd)"
FORCE=0

usage() {
  echo "Usage: $0 <target-repo-path> [--force]"
  echo ""
  echo "  target-repo-path   Path to the repo you want to set up CodeRelay in"
  echo "  --force            Overwrite existing files"
  exit 1
}

# Parse args
TARGET=""
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    --help|-h) usage ;;
    -*) echo "Unknown option: $arg"; usage ;;
    *) TARGET="$arg" ;;
  esac
done

if [ -z "$TARGET" ]; then
  usage
fi

if [ ! -d "$TARGET" ]; then
  echo "Error: '$TARGET' is not a directory"
  exit 1
fi

TARGET="$(cd "$TARGET" && pwd)"

echo "Setting up CodeRelay in: $TARGET"
echo ""

copy_file() {
  src="$1"
  dest="$2"
  dest_dir="$(dirname "$dest")"

  mkdir -p "$dest_dir"

  if [ -f "$dest" ] && [ "$FORCE" -eq 0 ]; then
    echo "  skip   $dest (already exists — use --force to overwrite)"
    return
  fi

  cp "$src" "$dest"
  echo "  wrote  $dest"
}

# src/ context files
copy_file "$CODERELAY_DIR/src/PROJECT_CONTEXT.md"  "$TARGET/src/PROJECT_CONTEXT.md"
copy_file "$CODERELAY_DIR/src/TASKS.md"            "$TARGET/src/TASKS.md"
copy_file "$CODERELAY_DIR/src/HANDOFF.md"          "$TARGET/src/HANDOFF.md"
copy_file "$CODERELAY_DIR/src/DECISIONS.md"        "$TARGET/src/DECISIONS.md"
copy_file "$CODERELAY_DIR/src/TAKEOVER_PROMPTS.md" "$TARGET/src/TAKEOVER_PROMPTS.md"
copy_file "$CODERELAY_DIR/src/SESSION_CHECKLIST.md" "$TARGET/src/SESSION_CHECKLIST.md"

# Claude Code hook
copy_file "$CODERELAY_DIR/src/.claude/settings.json"   "$TARGET/.claude/settings.json"

# Codex hook
copy_file "$CODERELAY_DIR/src/.codex/config.toml"                       "$TARGET/.codex/config.toml"
copy_file "$CODERELAY_DIR/src/.codex/hooks.json"                        "$TARGET/.codex/hooks.json"
copy_file "$CODERELAY_DIR/src/.codex/hooks/stop_handoff_check.sh"       "$TARGET/.codex/hooks/stop_handoff_check.sh"

chmod +x "$TARGET/.codex/hooks/stop_handoff_check.sh"

echo ""
echo "Done. Next steps:"
echo "  1. Fill in $TARGET/src/PROJECT_CONTEXT.md"
echo "  2. Add your first tasks to $TARGET/src/TASKS.md"
echo "  3. Restart Claude Code (or open /hooks) to activate the handoff hook"
