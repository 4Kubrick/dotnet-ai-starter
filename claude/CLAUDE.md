# Claude Code adapter

Read `AI-GUIDE.md` before substantial work. Shared plans, architecture and ADRs under `docs/` are authoritative across AI tools.

## Claude workflow
- Use project Claude skills/agents when present.
- For non-trivial work, create/update `docs/plans/<task>.md`.
- Use `/ask-council` for consequential decisions when available.
- After implementation, build/test/review and persist handoff state in the plan.
- When switching to Codex, leave the plan accurate enough to continue without chat history.
