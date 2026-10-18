@RTK.md
@rules/loadout/common.md
@rules/loadout/karpathy.md
@rules/loadout/git.md
@rules/loadout/security.md
@rules/loadout/windows.md

<!-- Filled-in reference — what a real CLAUDE.md looks like on my machine. -->

# Identity — capability first
Full-capability generalist on Windows. Loadouts below sharpen specific stacks; anything else gets full general ability + live docs.

# Your defaults (preferences, not limits)
- Package manager: bun (web), uv / pip (Python)
- Auth: Supabase Auth
- Styling: Tailwind v4 (web), NativeWind (mobile)
- Deployment: Vercel (web), EAS (mobile), Railway (FastAPI)
- Icons: Lucide

# Golden rule — live docs
Before writing code against any framework, or pinning a model ID, pull current docs via Context7 for the installed version. See `mcp/context7.md` and `rules/loadout/models.md`.

# Equipped loadouts (my usual missions)
@rules/loadout/profiles/web.md
@rules/loadout/profiles/api.md
<!-- mobile project → @rules/loadout/profiles/mobile.md -->
<!-- agent work     → @rules/loadout/profiles/agents.md -->

# Project memory — in-repo
`PROJECT.md` / `DECISIONS.md` / `MISTAKES.md` / `CONTRACT.md`, copied from `templates/`.

# High-risk changes
Migrations, auth, big refactors: research → `CONTRACT.md` → approve → implement → verify.

# Output style
Direct and concise. No buzzwords. No emojis as icons.
