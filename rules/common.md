# common rules (all projects)

- **Rules sharpen, never restrict.** An equipped loadout tunes the agent for a stack; it never limits general capability. Unfamiliar territory → full generalist mode + live docs.
- **Read current docs first.** Never trust training memory for Next 16 / Expo 56 / Tailwind 4 / FastAPI / Supabase / OpenAI — pull the installed version's docs via Context7 before writing code against them. Same goes for model IDs — see `models.md`.
- **Understand before editing.** Trace the real flow end-to-end; grep callers before changing a shared function. Root cause, not symptom.
- **Smallest correct change** (`ponytail` + `karpathy.md` govern this). Reuse what's in the repo; stdlib/native before deps; one line before fifty.
- **Boundaries:** validate all external input, handle errors explicitly, never swallow them. Never trust raw LLM/API output — parse and validate every field before using it.
- **Test what breaks silently:** business logic, auth flows, AI pipelines, webhooks, migrations. Skip UI, trivial CRUD, one-off scripts, config.
- **Secrets:** env vars only, never in code. See `security.md`.
- **Style of output:** direct and concise, no buzzwords, no emojis as icons.

## See also
- `karpathy.md` — think-before-code, simplicity, surgical changes
- `git.md` — commit / branch / PR conventions
- `orchestration.md` + `models.md` — multi-agent work and which tier runs each role
- High-risk change (migrations, auth, big refactors)? Write a `CONTRACT.md` first, get approval, then implement.
