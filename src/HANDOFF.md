# Handoff

## Current Goal

Add a Codex Stop hook that mirrors the existing Claude Code handoff reminder.

## What Was Just Finished

- Added repo-local Codex hook configuration in `.codex/hooks.json`.
- Enabled the experimental Codex hooks feature for this repo in `.codex/config.toml`.
- Added `.codex/hooks/stop_handoff_check.sh`, which checks whether `HANDOFF.md` has been updated in the last 5 minutes and asks Codex to continue if it is stale.
- Verified the hook JSON parses and the script emits the expected Codex Stop-hook continuation JSON when the handoff is stale.

## What Is In Progress

- No coding work is currently in progress.

## Next 3 Steps

1. Start a fresh Codex session in this repo and confirm the Stop hook runs automatically at session end.
2. Decide whether to document the Claude/Codex hook setup in `README.md`.
3. Commit `.claude/`, `.codex/`, and this updated handoff when ready.

## Important Files

- `.claude/settings.json`
- `.codex/config.toml`
- `.codex/hooks.json`
- `.codex/hooks/stop_handoff_check.sh`
- `src/HANDOFF.md`

## Commands To Run

- `python3 -m json.tool .codex/hooks.json`
- `/bin/sh .codex/hooks/stop_handoff_check.sh`
- `codex features list`

## Known Issues

- Codex hooks are experimental per OpenAI docs and are currently disabled on Windows.
- The current shell hook is intentionally portable and is invoked through `/bin/sh`, so executable file mode is not required.

## Constraints

- Keep the hook behavior lightweight and repo-local.
- Do not edit global `~/.codex/config.toml` unless explicitly requested.

## Notes For The Next Agent

The Codex hook mirrors the Claude setup: when Codex reaches `Stop`, it searches from the git root for `HANDOFF.md`; if the file exists and is older than 300 seconds, it returns `{"decision":"block","reason":"..."}` so Codex continues with a prompt to update the handoff.

## Fallback Model

If both Codex and Claude Code are unavailable or out of tokens, continue with local Ollama using Qwen Coder and the same handoff instructions.
