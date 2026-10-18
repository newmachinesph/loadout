# Changelog

## v0.1.0: 2026-07-04

Initial public release of **loadout** — Windows-only, capability-first agentic-dev foundation for Claude Code.

### Added
- Loadout profiles (`rules/profiles/`): web, mobile, api, agents — equip a specialization without losing general capability
- `CLAUDE.md` + `CLAUDE.example.md` — global instructions (thin; @imports the rule packs)
- Rule packs (`rules/`): common, karpathy, git, windows, nextjs, expo, fastapi, openai-agents, orchestration, models, security
- Memory templates (`templates/`): AGENTS, PROJECT, DECISIONS, MISTAKES, CONTRACT
- `setup.ps1` — one-command Windows install (ECC, RTK, Caveman, claude-mem, rule packs, CLAUDE.md); `-RulesOnly` for a no-tools install
- `mcp/context7.md` — live-docs wiring
- `STACK.md` — installed-tool inventory and the reasoning behind each choice
- `RTK.md` — token-compressor reference
- OSS packaging: MIT `LICENSE`, `CONTRIBUTING.md`, GitHub issue templates, changelog release workflow
