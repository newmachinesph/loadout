# Model routing (all projects)

Pick the cheapest tier that clears the task's bar. Keep model IDs in **one config constant**, never scattered literals (`openai-agents.md` says the same for the OpenAI side).

## Verify before you pin
Model names, IDs, and pricing move faster than any rules file. **Confirm the current lineup via the `claude-api` skill (or Anthropic's docs) before hardcoding an ID** — don't trust this table past its as-of date. When building AI features, default to the latest, most capable model for the role.

## Tiers by role (Claude, as of 2026-07)
| Role | Tier | Model ID | Use for |
|---|---|---|---|
| Deep reason / orchestrate | Opus 4.8 | `claude-opus-4-8` | architecture, hard reviews, orchestrator loop, adversarial verify |
| Long-context main loop | Fable 5 | `claude-fable-5` | orchestrator alternative; whole-repo context (`[1m]` variant) — confirm pricing via `claude-api` before fleet-scale use |
| Main dev workhorse | Sonnet 5 | `claude-sonnet-5` | day-to-day coding, most subagents |
| Cheap high-frequency worker | Haiku 4.5 | `claude-haiku-4-5-20251001` | mechanical fan-out, lint/format fixes, large parallel sweeps |

## Effort routing (the second dial)
Reasoning effort multiplies cost within a tier — route it like the tier:
- **low** — mechanical stages: renames, formatting, glob-and-report fan-out.
- **medium** — default build work.
- **high / max** — adversarial verify, judge panels, security and architecture calls.

## Heuristics
- **Orchestrator on a top tier, workers cheaper.** A Haiku fleet under an Opus/Fable orchestrator beats one expensive agent working serially.
- Escalate a stage to a higher tier/effort only when the cheaper one measurably fails it.
- Stakes match: mechanical rename = Haiku + low; security or architecture call = Opus + high.
- In the OpenAI Agents SDK the same rule holds — model per-agent in config, never scattered IDs.
