# Codex adapter

Read `AI-GUIDE.md` before substantial work. Shared plans, architecture and ADRs under `docs/` are authoritative across AI tools.

## Codex workflow
- Use project skills under `.agents/skills/` and agents under `.codex/agents/` when present.
- For non-trivial work, create/update `docs/plans/<task>.md`.
- Use `$ask-council` for consequential decisions when available.
- After implementation, build/test/review and persist handoff state in the plan.
- When switching to Claude, leave the plan accurate enough to continue without chat history.
