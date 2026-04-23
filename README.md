# CodeRelay

A lightweight handoff system for building software with multiple coding agents — without losing context.

Instead of keeping project memory inside a chat window, CodeRelay moves it into the repo itself. One agent stops, another picks up, and the work continues without thrashing, repetition, or re-explaining.

---

## Why

Most multi-agent workflows break down for the same reason: important context only lives inside a conversation. Once that window gets long, truncated, or unavailable, the next model has to reconstruct everything from scratch.

CodeRelay fixes that with a small set of durable Markdown files that travel with the repo:

| File | Purpose |
|---|---|
| `src/PROJECT_CONTEXT.md` | Product brief, stack, scope, commands, constraints |
| `src/TASKS.md` | Active backlog and current execution queue |
| `src/HANDOFF.md` | Live baton pass — goal, recent changes, next steps |
| `src/DECISIONS.md` | Architectural choices and the reasoning behind them |
| `src/TAKEOVER_PROMPTS.md` | Copy-paste prompts for each supported agent |
| `src/SESSION_CHECKLIST.md` | Repeatable start/end ritual for each session |

The repo becomes the source of truth, not the conversation.

---

## Quick Start

**1. Install into your project**

```sh
git clone https://github.com/yourname/coderelay
./coderelay/setup.sh /path/to/your/project
```

Pass `--force` to overwrite files that already exist.

**2. Fill in the context files**

Open `src/PROJECT_CONTEXT.md` and fill in your app summary, stack, commands, and constraints before any significant implementation starts.

**3. Work as normal**

Use Claude Code, Codex, or a local model as usual. End every session by updating `src/HANDOFF.md`.

**4. Switch agents**

When switching models, give the next agent the takeover prompt from `src/TAKEOVER_PROMPTS.md`. It will read the handoff files, inspect the listed files, and continue without needing the chat history.

---

## Switching Between Agents

```
Active agent hits token limit or you want to change tools
  → Ask agent to stop coding
  → Ask agent to update src/HANDOFF.md
  → Open the next agent
  → Paste the takeover prompt from src/TAKEOVER_PROMPTS.md
  → Continue
```

This works for any combination of:

- Codex → Claude Code
- Claude Code → Codex
- Either → local Ollama (Qwen Coder recommended as fallback)

---

## Automatic Handoff Hooks

CodeRelay ships with stop hooks for both Claude Code and Codex that check whether `HANDOFF.md` has been updated in the current session.

**Claude Code** (`.claude/settings.json`): Uses `asyncRewake` on the `Stop` event. If `HANDOFF.md` hasn't been touched in more than 5 minutes, Claude is re-awoken and asked to update it before the session fully closes.

**Codex** (`.codex/hooks.json` + `.codex/hooks/stop_handoff_check.sh`): Runs on the `Stop` event and blocks with a `decision: block` response if `HANDOFF.md` is stale, prompting Codex to update it.

Both hooks are installed automatically by `setup.sh`. After running setup, restart Claude Code (or open `/hooks`) to activate the Claude hook.

---

## Local Fallback With Ollama

If both hosted agents are unavailable or out of tokens, fall back to a local Ollama model. The model doesn't need the prior chat transcript — just give it:

- `src/PROJECT_CONTEXT.md`
- `src/TASKS.md`
- `src/HANDOFF.md`
- `src/DECISIONS.md`

Then tell it to inspect the files listed in `HANDOFF.md`, continue the current goal, and update `HANDOFF.md` before stopping.

---

## Repo Structure

```
coderelay/
├── setup.sh                          # Installs CodeRelay into a target repo
└── src/
    ├── .claude/
    │   └── settings.json             # Claude Code stop hook
    ├── .codex/
    │   ├── config.toml
    │   ├── hooks.json                # Codex stop hook config
    │   └── hooks/
    │       └── stop_handoff_check.sh # Handoff freshness check
    ├── PROJECT_CONTEXT.md
    ├── TASKS.md
    ├── HANDOFF.md
    ├── DECISIONS.md
    ├── TAKEOVER_PROMPTS.md
    └── SESSION_CHECKLIST.md
```

`setup.sh` copies the `src/` Markdown files to `target/src/` and places `.claude` and `.codex` at the target repo root where each agent expects them.

---

## The One Rule

**Every session ends with a handoff.**

If an agent stops without updating `HANDOFF.md`, the relay is incomplete and the next model will waste time rediscovering context. The hooks exist to enforce this, but the habit matters more than the tooling.

A good handoff is short and operational:

- What is the current goal?
- What was just completed?
- What is still in progress?
- What are the next 3 concrete steps?
- Which files matter most right now?
- Any bugs, blockers, or risks?

---

## Best Practices

- Keep handoffs specific — the next agent should be able to act immediately
- Record non-obvious decisions while they are fresh (`DECISIONS.md`)
- Prefer small, reviewable changes over sprawling edits
- Treat tests, lint, and repo state as shared truth across agents
- Never rely on any single chat session to preserve project understanding
