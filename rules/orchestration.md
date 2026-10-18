# Orchestration (multi-agent) — Windows

How to split work across subagents instead of doing everything in one context. Harness-agnostic principles; pair with `models.md` (which tier/effort runs each role) and `windows.md` (platform rules).

## When to orchestrate vs. do it inline
- **Inline** (no subagent): single-fact lookup, one known file, a trivial edit. Delegation overhead isn't worth it.
- **Delegate** when the answer means sweeping many files, the work is independent and parallelizable, or you want an independent perspective (review, verify, design). Keep the *conclusion*, not the file dumps.
- Once you delegate a search, don't also run it yourself — wait for the result.
- **Scout, then fan out** — discover the work-list inline (list files, scope the diff), *then* orchestrate over it.

## Stack routing — who works each layer
| Layer | Red build | Review lenses | Also |
|---|---|---|---|
| Next.js web | `react-build-resolver` | `react-reviewer` + `typescript-reviewer` | `e2e-runner` on critical flows |
| Expo mobile | `react-build-resolver` | `react-reviewer` + `typescript-reviewer` | verify on device — RN styling ≠ web CSS |
| FastAPI backend | `build-error-resolver` | `fastapi-reviewer` + `python-reviewer` | `database-reviewer` for Supabase schema/RLS |
| Cross-cutting | — | `security-reviewer` (auth, input, secrets) | `planner`/`architect` for design; `Explore` for read-only search |

Two cheap reviewers with different lenses beat one expensive generalist. Match the reviewer to the language actually touched.

## Full-stack feature playbook (contract-first)
1. **Scout inline** — scope the feature; list the files each layer touches.
2. **Contract first** — write the Pydantic schema + endpoint shape once; it is the single source of truth all layers code against.
3. **Fan out in parallel** — FastAPI endpoint, Next.js page, Expo screen: one agent each, the same contract pasted into every prompt.
4. **Verify per layer** — the routing table above; add `security-reviewer` whenever auth or input handling changed.
5. **Synthesize** — one integration pass end-to-end, then update `PROJECT.md`.

## Core patterns
- **Parallel by default** for independent work — one message, many agents. Never serialize independent steps.
- **Pipeline** for per-item stages (find → verify → fix) — no barrier; item A verifies while item B is still being found.
- **Barrier** (wait for all) only when the next stage needs *every* prior result at once — dedup across the set, early-exit on zero, "compare against the others."
- **Loop-until-dry** — unknown-size discovery (bugs, edge cases): keep spawning finders until 2 consecutive rounds surface nothing new. Fixed counts miss the tail.
- **Judge panel** — wide solution spaces (design, architecture): N independent attempts from different angles, parallel judges score, synthesize from the winner.
- **Completeness critic** — end big jobs with one agent asking "what's missing — a layer untouched, a claim unverified, a case untested?" Its findings seed the next round.

## Verify adversarially
- Non-trivial finding → independent skeptics prompted to **refute** it; kill it unless a majority survive.
- Give verifiers **distinct lenses** (correctness, security, does-it-reproduce), not N identical checkers — diversity catches what redundancy can't.
- Plausible-but-wrong findings die at the verify stage, not in production.

## Failure handling
- An agent that dies or returns empty → retry **once**; still empty → report it as dropped. Never silently skip an item.
- **No silent caps** — bounded coverage (top-N, sampling, no-retry) must state what was dropped.
- Partial completion is a *result*: report covered / not-covered explicitly.
- Budget: scale the fleet to the ask — "any bugs?" = few finders + single verify; "audit thoroughly" = bigger pool + multi-vote adversarial verify + synthesis. Cheap tier for fan-out, top tier for verify/synthesis (`models.md`).

## Windows specifics
- Subagents inherit **PowerShell** — no `&&`/`||`, no Unix coreutils; POSIX scripts need the Bash tool. Full platform rules: `windows.md`.
- **Absolute paths** across agents — working-dir assumptions don't survive delegation.
- **Worktree isolation** only when parallel agents mutate files and would collide; skip it for read-only fan-out (it costs setup + disk).
