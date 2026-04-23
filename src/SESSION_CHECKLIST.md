# Session Checklist

## Start Of Session

- Read `PROJECT_CONTEXT.md`
- Read `TASKS.md`
- Read `HANDOFF.md`
- Read `DECISIONS.md` if the work touches architecture or prior tradeoffs
- Inspect the files named in `HANDOFF.md`
- Confirm the next concrete goal

## During Session

- Keep changes scoped to the current task
- Update `TASKS.md` if priorities or status changed
- Add a decision note when making a non-obvious tradeoff
- Prefer small, testable steps

## End Of Session

- Update `HANDOFF.md`
- Move finished work in `TASKS.md`
- Record any important architecture decisions
- Note failing tests, blockers, or open questions
- Provide a takeover prompt for the next agent

## If You Are Switching Because Of Token Limits

- Stop active implementation before context gets too degraded
- Write the shortest useful handoff, not a long essay
- Include exact files and exact next steps
- Mention any command output the next agent needs
- If both hosted agents are exhausted, use the local Ollama Qwen Coder fallback with the same files and process
