# OpenAI Agents SDK + API

Verify against Context7 (OpenAI Agents SDK, `openai` python) before coding — SDK moves fast.

- Use the **Agents SDK** primitives: `Agent`, `Runner`, function tools, handoffs, guardrails. Don't hand-roll an agent loop when the SDK covers it.
- API key from env (`OPENAI_API_KEY`), never in code.
- Function tools + structured outputs use **Pydantic** schemas — reuse the FastAPI models.
- Stream when UX benefits; handle rate limits + retries/backoff.
- Keep model IDs in config, not scattered literals — see `models.md` for tiers and routing.
- Orchestrating your own multi-agent flows (Claude Code subagents/workflows)? See `orchestration.md`.
