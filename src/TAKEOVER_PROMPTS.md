# Takeover Prompts

Ready-to-paste prompts for handing work between agents.

The prompts are intentionally lean. Research shows that loading agents with broad context files increases inference cost and reduces task success. Each prompt loads only what the agent cannot derive from the code itself.

---

## Universal Takeover Prompt

```text
You are taking over this project from another coding agent.

Start here:
1. Read src/HANDOFF.md
2. Read src/TASKS.md
3. Inspect the files listed under "Important Files" in HANDOFF.md

Only read src/DECISIONS.md if your work touches existing architecture decisions.
Only read src/PROJECT_CONTEXT.md if you need the run/test commands and cannot find them elsewhere.

Do not read files speculatively — inspect what HANDOFF.md points you to, then proceed.

Current objective: [paste from HANDOFF.md]

Rules:
- Make targeted changes only
- Do not refactor unrelated code
- Preserve existing style and architecture unless the handoff says otherwise
- Before coding: confirm your understanding and list your next steps
- Update src/HANDOFF.md before stopping
```

---

## End-of-Session Prompt

Use this to close out a session cleanly.

```text
Before stopping, update src/HANDOFF.md with:
- current goal (one sentence)
- what is still in progress
- next 3 concrete steps
- files the next agent should inspect first
- any blockers or open risks

Keep it brief. Do not summarize what you did — that is what git log is for.
```

---

## Codex Takeover Prompt

```text
Take over this project from another coding agent.

1. Read src/HANDOFF.md
2. Read src/TASKS.md
3. Inspect the files listed under "Important Files" in HANDOFF.md

Only consult src/DECISIONS.md if your changes touch existing architecture.

Rules:
- Make targeted edits only
- Run verification if available
- Do not undo unrelated changes
- Update src/HANDOFF.md before stopping
```

---

## Claude Code Takeover Prompt

```text
Take over this project from another coding agent.

1. Read src/HANDOFF.md
2. Read src/TASKS.md
3. Inspect the files listed under "Important Files" in HANDOFF.md

Only consult src/DECISIONS.md if your changes touch existing architecture.

Before coding:
- Confirm your understanding of the current goal
- Flag any risks or ambiguities early
- List your next concrete steps

Update src/HANDOFF.md before stopping.
```

---

## Local Ollama Fallback Prompt

Use only if both Codex and Claude Code are unavailable or out of tokens.

```text
You are taking over this project as the fallback coding model.

1. Read src/HANDOFF.md
2. Read src/TASKS.md
3. Inspect the files listed under "Important Files" in HANDOFF.md

Rules:
- Make the smallest reasonable change set
- Do not refactor unrelated code
- Preserve existing style and structure
- Before coding: summarize your understanding and list next steps
- Update src/HANDOFF.md before stopping
```

---

## Review Prompt

Use when one agent has implemented something and you want the other to review it.

```text
Review the current changes in this repo.

Read:
- src/HANDOFF.md
- src/DECISIONS.md

Focus on:
- bugs and regressions
- missing or broken tests
- risky assumptions
- inconsistencies with stated constraints

Give findings first, then suggested fixes. Update src/HANDOFF.md with any follow-up work.
```
