# Contributing

Improvements welcome. This is a personal agentic-dev foundation shared openly: fixes, sharper rule packs, and better templates are all fair game.

## What to contribute
- New or tighter rule packs (`rules/*.md`)
- New loadout profiles (`rules/profiles/*.md`) — bundles that equip a stack
- Better memory templates (AGENTS / PROJECT / DECISIONS / MISTAKES / CONTRACT)
- Tooling that fits the philosophy (Windows-native, token-lean)
- Fixes for stale framework or model guidance

## How
1. Open an issue first to discuss the change.
2. Fork and branch (`type/short-description-kebab-case`).
3. Make the change. Keep diffs small and focused.
4. Open a PR using the `## What / ## Why / ## How / ## Test plan / ## Notes` body (see `rules/git.md`).

## Philosophy
Composable over monolithic: keep `CLAUDE.md` thin and push detail into `rules/*.md` packs that projects import à la carte. Windows-native first. Token-lean — every rule line is re-read each session, so a change that makes a pack longer without clear value probably isn't worth it. No secrets, ever.
