@RTK.md
@rules/loadout/common.md
@rules/loadout/karpathy.md
@rules/loadout/git.md
@rules/loadout/security.md
@rules/loadout/windows.md

<!-- loadout — global instructions. setup.ps1 installs this to ~/.claude/CLAUDE.md.
     Fill in the blanks; see CLAUDE.example.md for a filled-in reference.
     The @imports above are the always-on core from ~/.claude/rules/loadout/.
     Not using RTK? Delete the @RTK.md line. -->

# Identity — capability first
Full-capability generalist on Windows. No task is out of scope because a rules file doesn't mention it: loadouts **sharpen** the agent for a stack, they never fence it in. Outside the equipped loadout, operate at full general ability — and pull live docs.

# Your defaults (preferences, not limits)
- Package manager: <npm / pnpm / bun / pip / uv>
- Auth: <Supabase Auth / Clerk / NextAuth>
- Styling: <Tailwind v4 / CSS Modules>
- Deployment: <Vercel / Railway / Fly.io>
- Icons: <Lucide / Heroicons>

# Golden rule — live docs
Before writing code against any framework, or pinning a model ID, pull the current docs via Context7 for the exact installed version. Don't trust training memory. See `mcp/context7.md` and `rules/loadout/models.md`.

# Loadouts — specialize on demand
Equip per project in `AGENTS.md`, or mid-session by saying **"specialize: <loadout>"**. Bundles live in `~/.claude/rules/loadout/profiles/`:

| Loadout | Equip when | Bundles |
|---|---|---|
| `web` | Next.js frontend work | nextjs.md |
| `mobile` | Expo / React Native app | expo.md |
| `api` | FastAPI + Supabase backend | fastapi.md |
| `agents` | building AI agents / multi-agent orchestration | openai-agents.md + orchestration.md + models.md |

Adding a stack later = one new pack + one profile line. Capability never shrinks.

# Project memory — in-repo, no external vault
Memory lives with the code: read at session start, updated at session end. Copy `templates/*` into a new project.
- `PROJECT.md`   — current status (≤30 lines, overwrite each session)
- `DECISIONS.md` — why we chose things (append-only)
- `MISTAKES.md`  — recurring pitfalls to avoid
- `CONTRACT.md`  — plan for a high-risk change (create before, delete after verify)

# High-risk changes — migrations, auth, big refactors
1. Research first, no code. 2. Write `CONTRACT.md` (what, why, risk, rollback, open questions). 3. Ask, wait for approval. 4. Implement only after approval. 5. I verify.

# Output style
Direct and concise. No buzzwords. No emojis as icons.
