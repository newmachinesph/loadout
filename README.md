# loadout

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
![Claude Code](https://img.shields.io/badge/Claude%20Code-rules%20%2B%20memory-D97757)
![PowerShell](https://img.shields.io/badge/PowerShell-Windows%2011-5391FE?logo=powershell&logoColor=white)

A reusable, Windows-native setup for Claude Code: Markdown rule packs, loadout profiles, per-project memory templates, and a PowerShell installer (`setup.ps1`) that copies them into `~/.claude` and optionally installs the supporting tools (ECC, RTK, Caveman, claude-mem). It is for developers on Windows who want the same agent instructions and memory conventions on every project and every machine. There is no app, build, or test suite here, only Markdown and one script.

**Give your agent a loadout.** A Windows-only, capability-first foundation for Claude Code (and other harnesses): the agent stays a **full generalist** — you *equip* a specialization (`web` / `mobile` / `api` / `agents`) when the mission calls for it. Rules sharpen, never restrict.

Core stack today: **Next.js 16 · React 19 · Tailwind v4 · Expo 56 · NativeWind · FastAPI · Supabase**. Scalable on purpose: a new stack = one rule pack + one profile line.

Think of this as *my own basecamp* — a reusable base I apply to every project, built on the
most-starred community harness (**ECC**) plus my own stack rules, memory, and safety.

---

## Quick start

```powershell
git clone https://github.com/newmachinesph/loadout.git
cd loadout
.\setup.ps1              # full install: ECC + RTK + Caveman + claude-mem + rules + CLAUDE.md
# or
.\setup.ps1 -RulesOnly   # just the rule packs + CLAUDE.md — no external tools
```

Then open `~/.claude/CLAUDE.md`, fill in your stack (see [CLAUDE.example.md](./CLAUDE.example.md)), and restart Claude Code.

---

## The mental model — every agent "setup" is 4 layers

| Layer | What it is | Where it lives |
|-------|------------|----------------|
| 1. **Instructions** | Rules the agent re-reads every session | `~/.claude/CLAUDE.md` → `@AGENTS.md` + `rules/*.md` |
| 2. **Memory** | What survives between sessions | `templates/` copied into each project |
| 3. **Tools (MCP) + skills** | Live docs, real browser, DB access, skills | ECC + `.mcp.json` (Context7) |
| 4. **Safety** | Block dangerous commands, scan for secrets | `.claude/settings.json` hooks + ECC agentshield |

Base harness: **ECC** (`affaan-m/ECC`) — the most-starred Claude Code harness (~226K⭐, MIT,
cross-harness, Windows-native). It provides skills, memory optimization, security scanning, and
research-first workflow. This repo layers *my stack* on top of it.

---

## What's in here

```
loadout/
├─ README.md              ← this file: the map + how to reuse
├─ CLAUDE.md              ← global instructions template (thin; @imports rule packs)
├─ CLAUDE.example.md      ← filled-in reference for my stack
├─ STACK.md               ← what's installed + why (inventory & decisions)
├─ RTK.md                 ← token-compressor reference (@imported by CLAUDE.md)
├─ setup.ps1              ← Windows installer (tools + rules + CLAUDE.md into ~/.claude; prints manual plugin steps)
├─ skills-lock.json       ← pinned Caveman skill sources + hashes
├─ rules/                 ← my stack rule packs (the real value)
│   ├─ common.md          ← read-current-docs, boundaries, test-what-breaks; hub for the rest
│   ├─ karpathy.md        ← think-before-code, simplicity, surgical changes
│   ├─ git.md             ← commit / branch / PR conventions
│   ├─ windows.md         ← OneDrive, long paths, Defender, PowerShell, firewall/adb
│   ├─ nextjs.md          ← Next 16 + React 19 + Tailwind v4
│   ├─ expo.md            ← Expo 56 + React Native + NativeWind
│   ├─ fastapi.md         ← FastAPI + Pydantic v2 + Supabase
│   ├─ openai-agents.md   ← OpenAI Agents SDK + API
│   ├─ orchestration.md   ← multi-agent: subagents, parallel/pipeline, adversarial verify
│   ├─ models.md          ← model tiers + routing (Opus 4.8 / Sonnet 5 / Haiku 4.5)
│   ├─ security.md        ← secrets, keys, safe defaults
│   └─ profiles/          ← loadouts: web · mobile · api · agents (equip per project)
├─ templates/             ← per-project memory (Layer 2)
│   ├─ AGENTS.md          ← starter (CLAUDE.md just does `@AGENTS.md`)
│   ├─ PROJECT.md         ← current status, ≤30 lines
│   ├─ DECISIONS.md       ← why we chose X
│   ├─ MISTAKES.md        ← recurring pitfalls to avoid
│   └─ CONTRACT.md        ← plan for a high-risk change (create → approve → delete)
├─ mcp/
│   └─ context7.md        ← how the live-docs MCP is wired
├─ .github/               ← issue templates + changelog release workflow
├─ LICENSE                ← MIT
├─ CONTRIBUTING.md        ← how to contribute
└─ CHANGELOG.md           ← version history
```

---

## Build log (how this foundation was assembled)

- [x] **1. Create `loadout/` + git init**
- [x] **2. Install ECC** — `npx -p ecc-universal ecc-install --profile minimal --target claude` (21 skills; minimal = no global hooks)
- [x] **3. gstack overlap check** — none found (ECC added no hooks; gstack's only hook is a benign auto-updater). Keeping both.
- [x] **4. Context7 live-docs** — already enabled globally; verified pulling Next.js **v16.2.9** docs
- [x] **4b. Token-saving stack** — RTK + Caveman + claude-mem (see [STACK.md](./STACK.md))
- [x] **5. Rule packs** (`rules/*.md`) — Next 16, Expo 56, Tailwind 4, FastAPI/Supabase, OpenAI Agents, common, security
- [x] **6. Memory templates** (`templates/` AGENTS/PROJECT/DECISIONS/MISTAKES)
- [x] **7. Safety** — `safety-hooks` plugin (user-level) + ECC AgentShield (`/security-scan`)
- [ ] **8. ~~Install Obsidian~~** — **skipped**: in-repo markdown memory + ECC continuous-learning beats an external vault.
- [x] **9. `setup.ps1`** — one-command reinstall on a new machine
- [ ] **10. Test-drive** — `fastapi-reviewer` on a real FastAPI backend (not yet recorded as done)

## Memory approach (decided)
- **Project memory** → in-repo `PROJECT.md` / `DECISIONS.md` / `MISTAKES.md` (versioned with code, reaches teammates).
- **Cross-session instincts** → ECC `continuous-learning` skill (auto).
- **Obsidian** → optional viewer only; never the backend.

---

## How to reuse this on a new project

```powershell
# 1. copy the AGENTS.md + memory templates into the project
Copy-Item templates\* <your-project>\ -Force
# 2. in the project, CLAUDE.md is just:  @AGENTS.md
# 3. equip loadouts inside AGENTS.md, e.g.  @~/.claude/rules/loadout/profiles/web.md
```

## Requirements
- Windows 11, Claude Code, Node.js 18+, Git. Bun optional.
- No Obsidian needed — project memory is in-repo markdown (`templates/`).

## FAQ

**What's a loadout?** A named bundle of rule packs (`rules/profiles/`) you equip per project — or mid-session with "specialize: web". Specialization without capability loss: the agent stays a full generalist underneath.

**Why Windows-only?** Every other Claude Code foundation assumes macOS/bash. This one is PowerShell-native end to end — installer, rules, orchestration notes. No WSL required.

**Do I need Obsidian?** No. Memory is in-repo markdown, versioned with the code, visible to teammates.

**Can I use just the rules?** Yes — `.\setup.ps1 -RulesOnly` installs the rule packs + CLAUDE.md and skips ECC, RTK, Caveman, and claude-mem entirely.

**Only Next/Expo/FastAPI?** That's the core today. Packs are à la carte — add your own `rules/<stack>.md` and the installer picks it up with zero script changes.

## Troubleshooting

- **`setup.ps1` won't run** → `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`, or one-off: `powershell -ExecutionPolicy Bypass -File setup.ps1`.
- **`rtk` not found after install** → the updated PATH needs a fresh terminal; verify with `where.exe rtk`.
- **ECC GateGuard denies file edits** → by design it blocks the first touch per file once; the retry passes. Heavy scaffolding: `ECC_GATEGUARD=off`.
- **Repo inside OneDrive misbehaving** → see [rules/windows.md](./rules/windows.md) — sync locks vs git/`node_modules`.

## License

MIT — see [LICENSE](LICENSE).
