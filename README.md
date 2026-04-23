# CodeRelay

CodeRelay is a simple handoff system for building software with multiple coding agents without losing context.

Instead of treating Codex, Claude Code, or a local Ollama model as the place where the project's memory lives, CodeRelay moves that memory into the repository itself. The result is a workflow where one agent can stop, another can take over, and the work continues with far less thrashing, repetition, or re-explaining.

This is especially useful when:

- one hosted model hits token limits
- you want one agent to implement and another to review
- you need a local fallback when remote tools are unavailable
- you want a project to remain understandable even after many agent switches

## What CodeRelay Solves

Most multi-agent workflows break down for the same reason: the important context only exists inside a chat window. Once that window gets long, truncated, or unavailable, the next model has to reconstruct too much from scratch.

CodeRelay fixes that by giving the project a shared memory layer made of small, durable files:

- `PROJECT_CONTEXT.md` for product and technical context
- `TASKS.md` for what is active, next, blocked, and done
- `HANDOFF.md` for the live baton pass between agents
- `DECISIONS.md` for architectural reasoning and non-obvious choices
- `TAKEOVER_PROMPTS.md` for ready-to-paste prompts
- `SESSION_CHECKLIST.md` for a repeatable session ritual

## How It Works

The workflow is intentionally lightweight:

1. Start a project and fill in the context files.
2. Work with Codex or Claude Code as usual.
3. Before stopping, update `HANDOFF.md`.
4. Start the next agent by having it read the handoff files and inspect the key files listed there.
5. Continue working without depending on fragile chat history.

The repo becomes the source of truth, not the conversation.

## Recommended Relay Order

CodeRelay works best with a clear fallback order:

1. Codex
2. Claude Code
3. Local Ollama Qwen Coder as last resort

That order is flexible, but the principle stays the same: every agent reads from and writes back to the same shared memory files.

## Included Files

- `PROJECT_CONTEXT.md`
  The product brief, stack, scope, commands, constraints, and definition of done.
- `TASKS.md`
  The working backlog and current execution queue.
- `HANDOFF.md`
  The current goal, recent changes, next steps, files to inspect, risks, and constraints.
- `DECISIONS.md`
  A log of important implementation choices and why they were made.
- `TAKEOVER_PROMPTS.md`
  Copy-paste prompts for Codex, Claude Code, and the Ollama fallback.
- `SESSION_CHECKLIST.md`
  A short operational checklist for starting and ending a session cleanly.

## Quick Start

1. Copy the contents of this folder into the root of your app repo.
2. Fill in `PROJECT_CONTEXT.md` before significant implementation starts.
3. Update `TASKS.md` as priorities move.
4. Require every agent session to end by updating `HANDOFF.md`.
5. When switching models, start the next one with a takeover prompt from `TAKEOVER_PROMPTS.md`.

## The Most Important Rule

Every session ends with a handoff.

If an agent stops without updating `HANDOFF.md`, the relay is incomplete. That usually means the next model will waste time rediscovering context, repeating work, or missing constraints.

The handoff should be short and useful, not exhaustive. It should tell the next agent:

- what the current goal is
- what just changed
- what is still in progress
- the next 3 concrete steps
- which files matter most right now
- any bugs, blockers, or risks

## Switching Between Agents

When one model is running low on tokens or you want to change tools:

1. Ask the active model to stop coding.
2. Ask it to update `HANDOFF.md`.
3. Ask it to summarize what changed, what remains, and what the next model should inspect first.
4. Open the next model.
5. Paste a takeover prompt and continue.

This works whether you are switching:

- from Codex to Claude Code
- from Claude Code back to Codex
- from both hosted agents to a local Ollama model

## Local Fallback With Ollama

If both Codex and Claude Code are unavailable or out of tokens, CodeRelay can fall back to a local Ollama model. The intended fallback is Qwen Coder.

The local model does not need the prior chat transcript if the project memory is current. Give it:

- `PROJECT_CONTEXT.md`
- `TASKS.md`
- `HANDOFF.md`
- `DECISIONS.md`

Then tell it to inspect the files listed in `HANDOFF.md`, continue the current goal, and update `HANDOFF.md` before stopping.

## Best Practices

- Keep handoffs operational and specific.
- Prefer small, reviewable changes over sprawling edits.
- Record non-obvious decisions while they are fresh.
- Treat tests, lint, and the repo state as shared truth.
- Do not rely on any single chat session to preserve project understanding.

## Who This Is For

CodeRelay is a good fit if you:

- build apps with more than one coding model
- frequently hit context or token limits
- want a resilient workflow for long-running projects
- need a cleaner way to pause and resume implementation

It is less useful if you only ever work in one short-lived session with one model.

## Philosophy

CodeRelay is not an orchestration framework, agent runner, or benchmark harness. It is a durable project-memory pattern.

Its job is to make agent switching boring in the best possible way: clean, predictable, and low-friction.
