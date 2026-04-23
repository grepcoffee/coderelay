# Takeover Prompts

These are ready-to-paste prompts for handing work between Codex, Claude Code, and a local Ollama fallback model.

## Universal Takeover Prompt

```text
You are taking over this app build.

Read these first:
- README.md
- PROJECT_CONTEXT.md
- TASKS.md
- HANDOFF.md
- DECISIONS.md

Then inspect the files listed in HANDOFF.md.

Current objective:
[paste the current objective]

Constraints:
- Do not refactor unrelated code
- Prefer minimal, targeted changes
- Preserve the existing style and architecture unless the handoff says otherwise
- Update HANDOFF.md before stopping

Before coding:
1. Summarize your understanding
2. List the next concrete steps
3. Then implement them
```

## Prompt To End A Session Cleanly

```text
Before stopping, update HANDOFF.md with:
- what you changed
- what remains
- known issues or risks
- exact next steps
- the files the next agent should inspect first

Also give me:
- a short summary of the work completed
- any failing tests or blockers
- a ready-to-paste takeover prompt for the next LLM
```

## Codex Takeover Prompt

```text
Take over this project from another coding agent.

Start by reading:
- README.md
- PROJECT_CONTEXT.md
- TASKS.md
- HANDOFF.md
- DECISIONS.md

Then inspect the files named in HANDOFF.md and continue the current goal.

Rules:
- Make targeted edits only
- Run relevant verification if available
- Do not undo unrelated existing changes
- Update HANDOFF.md before you stop
```

## Claude Code Takeover Prompt

```text
Take over this project from another coding agent.

Read:
- README.md
- PROJECT_CONTEXT.md
- TASKS.md
- HANDOFF.md
- DECISIONS.md

Then review the files listed in HANDOFF.md and continue the current objective.

Please:
- summarize your understanding first
- flag any architectural or product risks early
- make targeted changes
- update HANDOFF.md before stopping
```

## Local Ollama Qwen Coder Fallback Prompt

Use this only if both Codex and Claude Code are unavailable or out of tokens.

```text
You are taking over this project as the fallback coding model.

Read these files first:
- README.md
- PROJECT_CONTEXT.md
- TASKS.md
- HANDOFF.md
- DECISIONS.md

Then inspect the files listed in HANDOFF.md.

Current objective:
[paste the current objective]

Rules:
- Make the smallest reasonable change set
- Do not refactor unrelated code
- Preserve the existing style and structure unless the handoff says otherwise
- Update HANDOFF.md before stopping

Before coding:
1. Summarize your understanding
2. List the next concrete steps
3. Then implement them
```

## Ollama Run Hint

If you use Ollama from a terminal, pair the model with the handoff files rather than relying on memory from earlier sessions. The important part is not the exact command but that the model receives the current repo context and updates `HANDOFF.md` before you switch away from it.

## Review Prompt

Use this when one agent has implemented something and you want the other to review it.

```text
Review the current changes in this repo.

Read:
- PROJECT_CONTEXT.md
- TASKS.md
- HANDOFF.md
- DECISIONS.md

Focus on:
- bugs
- regressions
- missing tests
- risky assumptions
- inconsistencies with the stated constraints

Give findings first, then suggested fixes. Update HANDOFF.md with any important follow-up work.
```
