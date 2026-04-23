# Claude Code Instructions

## Start of every session

1. Read `src/HANDOFF.md`
2. Read `src/TASKS.md`
3. Inspect the files listed under "Important Files" in `HANDOFF.md`
4. Read `src/DECISIONS.md` only if your work touches existing architecture decisions
5. Read `src/PROJECT_CONTEXT.md` only if you need run or test commands

Do not read files speculatively. Start with `HANDOFF.md` and go from there.

## End of every session

Before stopping, update `src/HANDOFF.md` with:
- Current goal (one sentence)
- What is still in progress
- Next 3 concrete steps
- Files the next agent should inspect first
- Any blockers or open risks

Keep it under a page. Do not summarize what you did — that belongs in `git log`.
