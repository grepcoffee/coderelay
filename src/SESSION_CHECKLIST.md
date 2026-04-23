# Session Checklist

## Start of Session

- [ ] Read `src/HANDOFF.md`
- [ ] Inspect the files listed under "Important Files"
- [ ] Read `src/TASKS.md` to confirm current priorities
- [ ] Read `src/DECISIONS.md` only if this work touches existing architecture
- [ ] Confirm the next concrete goal before writing any code

Do not read `PROJECT_CONTEXT.md` speculatively. Load it only if you need the run/test commands and cannot find them in the codebase.

## During Session

- [ ] Keep changes scoped to the current task
- [ ] Update `src/TASKS.md` if priorities or status change
- [ ] Log non-obvious tradeoffs in `src/DECISIONS.md` while the reasoning is fresh
- [ ] Prefer small, testable steps over large sweeping changes

## End of Session

- [ ] Update `src/HANDOFF.md` — current goal, in progress, next 3 steps, important files, blockers
- [ ] Move completed items in `src/TASKS.md`
- [ ] Keep the handoff short. Do not summarize what you did — write only what the next agent cannot derive from `git log` or the code

## Switching Because of Token Limits

- [ ] Stop implementation before context degrades too far
- [ ] Write the handoff before your output quality drops
- [ ] Include exact file paths and exact next steps — not general summaries
- [ ] If both hosted agents are out, use the Ollama fallback prompt in `TAKEOVER_PROMPTS.md`

## What Belongs in These Files

| File | Write this | Not this |
|---|---|---|
| `HANDOFF.md` | Current goal, next steps, blockers | What you just did (git log), commands (PROJECT_CONTEXT) |
| `PROJECT_CONTEXT.md` | Commands, constraints, external deps | App description, user flows, anything in the code |
| `DECISIONS.md` | Non-obvious tradeoffs and why | Obvious implementation details |
| `TASKS.md` | Status and priority | Implementation notes |
