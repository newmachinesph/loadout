# Installed stack — inventory & decisions

The full agentic-dev environment on this machine, why each piece is here, and how it's wired.
Layers refer to the 4-layer model in [README.md](./README.md).

## What's installed

| Tool | Layer | Purpose | Install | Scope / location | Activates |
|------|-------|---------|---------|------------------|-----------|
| **ECC** (minimal) | 1,2,3,4 | Base harness: 21 skills, agents, rules, security scan | `npx -p ecc-universal ecc-install --profile minimal --target claude` | `~/.claude/skills/ecc`, `~/.claude/rules/ecc` | on restart |
| **gstack** | 3 | `/browse` + workflow skills (kept alongside ECC — no conflict) | (already installed) | `~/.claude/skills/gstack` | live |
| **Context7** | 3 | Live docs (Next 16 / Expo 56 / FastAPI…) — fixes stale-training-data | `claude plugin marketplace add upstash/context7` + `claude plugin install context7` | plugin `context7@context7-marketplace` | on restart |
| **RTK** v0.43 | — (token) | Compresses bash/git/test output 60-90% | prebuilt Windows binary | `~/.local/bin/rtk.exe` + `PreToolUse:Bash` hook | on restart |
| **Caveman** (core) | — (token) | Terse response mode, ~65% output-token cut, toggleable | `npx skills add JuliusBrussee/caveman -g -a claude-code -s caveman` | `~/.claude/skills/caveman` | on restart |
| **claude-mem** v13.10 | 2 | Persistent cross-session memory | `npx claude-mem install` | plugin `claude-mem@thedotmack`, data in `~/.claude-mem` | worker + 2nd session |

## Key decisions (the "why")

- **ECC over building from scratch** — most-starred harness (~226K⭐), MIT, Windows-native, cross-harness. **minimal** profile chosen to avoid global runtime hooks.
- **RTK over Headroom** — both compress context (they're alternatives, not a stack). RTK integrates via a `settings.json` hook (works with the VS Code extension) and needs no Rust; Headroom wraps the `claude` CLI launch, which the extension bypasses.
- **claude-mem over ECC continuous-learning** — one auto-memory system only (two = double context injection). ECC `continuous-learning` stays **dormant** (minimal has no auto-hook), claude-mem is primary. Project memory still lives in-repo (`templates/`).
- **Caveman: core skill only** — the security scanner flagged `caveman-compress` **High Risk** and `caveman-review` **Medium**; installed only the safe core `caveman`.

## Stack rule packs (2027-ready)
Layer-1 instructions live in `rules/` and install to `~/.claude/rules/loadout/` via `setup.ps1` (recursive copy — new packs and loadout profiles need no script change).
- **Borrowed from basecamp** (adapted to Windows/ECC): `karpathy.md` (think-before-code principles), `git.md` (full commit/branch/PR conventions), and the `CONTRACT.md` template (high-risk-change gate: research → contract → approve → implement).
- **New for orchestration**: `orchestration.md` (subagents, parallel/pipeline, adversarial verify, Windows/PowerShell notes) and `models.md` (tier routing — Opus 4.8 orchestrate / Sonnet 5 build / Haiku 4.5 fan-out).
- **Kept version-agnostic on purpose** — hardcoded framework pins (Next 16.x, Expo 56) and model IDs are "verify current via Context7 / `claude-api`" markers, not ground truth. That's what keeps this forward-compatible.

## Manual steps still required (interactive)

```text
# 1. Safety plugins (run in Claude Code chat):
/plugin marketplace add poshan0126/dotclaude
/plugin install safety-hooks@dotclaude
/plugin marketplace add DietrichGebert/ponytail
/plugin install ponytail@ponytail

# 2. Start the claude-mem worker (terminal):
npx claude-mem start        # keep http://localhost:37777 reachable

# 3. Restart Claude Code   → activates RTK hook, caveman, claude-mem, ECC + gstack skills
```

## Toggles / gotchas
- **ECC GateGuard fact-forces the first Write/Edit/Bash per file each session** — one denial, then the retry passes. Scaffolding-heavy session? Set `ECC_GATEGUARD=off` or add the hook to `ECC_DISABLED_HOOKS`.
- **Caveman is terse-by-default from next session.** Say **"normal mode"** for full explanations; `/caveman` to re-enable.
- **RTK** only filters **Bash** tool calls; Claude Code's Read/Grep/Glob bypass the hook (use shell `cat`/`rg` or `rtk read`/`rtk grep` for filtering there). Check savings: `rtk gain`.
- **claude-mem** memory appears from the **2nd** session in a project.
