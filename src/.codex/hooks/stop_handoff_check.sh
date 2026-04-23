#!/bin/sh

set -u

ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
HANDOFF=$(find "$ROOT" -maxdepth 3 -name 'HANDOFF.md' 2>/dev/null | head -n 1)

if [ -z "$HANDOFF" ]; then
  exit 0
fi

LAST=$(stat -f %m "$HANDOFF" 2>/dev/null || stat -c %Y "$HANDOFF" 2>/dev/null || echo "")

case "$LAST" in
  ''|*[!0-9]*)
    exit 0
    ;;
esac

NOW=$(date +%s)
AGE=$((NOW - LAST))

if [ "$AGE" -le 300 ]; then
  exit 0
fi

printf '%s\n' '{"decision":"block","reason":"HANDOFF.md has not been updated in this session. Please update it now with: current goal, what was just completed, what is in progress, next 3 steps, important files, and any blockers or risks. Keep it brief and operational, just enough for the next agent to pick up without rereading the conversation."}'
