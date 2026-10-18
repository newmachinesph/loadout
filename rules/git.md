# Git conventions (all projects)

## Ground rules
- **Never commit or push unless asked.** Review the diff before every commit.
- **No attribution.** No `Co-Authored-By` / "Generated with" trailers (disabled globally in `~/.claude/settings.json`).
- **Atomic commits** — one logical change each. No WIP commits on the default branch; branch first.
- **Never commit secrets** — API keys, passwords, `.env`, personal data. See `security.md`.
- Squash noise before merging. Keep history readable.

## Commit format
```
type(scope): imperative subject
```
- Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, `ci`.
- Scope optional — area changed (`auth`, `api`, `ui`, `db`).
- Imperative mood (`add`, not `added`). Subject ≤72 chars, no trailing period.
- Body (after a blank line) explains **why**, not what.
- Breaking change: `!` after scope + `BREAKING CHANGE:` footer. Issues: `Closes #123` footer.

## Branch naming
```
type/short-description-kebab-case   e.g. feat/auth-magic-link, fix/api-null-response
```

## Pull requests
Title = commit-subject format. Body:
```
## What   — one sentence, what changed
## Why    — one sentence, why it was needed
## How    — key decisions, only if non-obvious
## Test plan — how to verify; before/after steps
## Notes  — breaking changes, follow-ups
```
Keep PRs small and focused — one feature or fix each. Link issues (`Closes #123`).

## Windows note
Multi-line commit messages from PowerShell: use a single-quoted here-string so `$` and backticks stay literal, and keep the closing `'@` at column 0.
```powershell
git commit -m @'
feat(api): add retry on webhook timeout

Stripe fires webhooks twice on timeout; retry is idempotent.
'@
```
