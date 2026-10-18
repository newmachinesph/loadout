# Context7 — live docs (Layer 3)

**Status:** installed as plugin `context7@context7-marketplace` (`claude plugin marketplace add upstash/context7`, then `claude plugin install context7`).

## Why it matters for this stack
Your versions ship faster than model training data:
- **Next.js 16** made `cookies` / `headers` / `params` / `searchParams` **async** (must `await`). A model
  trained pre-16 writes `params.slug` — which now throws.
- **Expo 56**, **Tailwind v4**, **NativeWind 4**, **FastAPI**, **Supabase** all move fast too.

Context7 fetches the *current* docs on demand so the agent codes against reality, not memory.

## How to use it (the pattern)
1. **Resolve** the library id (once): ask for the library by proper name.
   - `resolve-library-id("Next.js")` → `/vercel/next.js` (versions incl. `v16.2.9`)
2. **Query** the version-pinned id with a specific question:
   - `query-docs("/vercel/next.js/v16.2.9", "async request APIs + caching defaults")`

## Library IDs for this stack (pin the version you use)
| Library | Context7 ID | Pin |
|---|---|---|
| Next.js | `/vercel/next.js` | `/vercel/next.js/v16.2.9` |
| Expo | `/expo/expo` | resolve to v56 |
| Tailwind CSS | `/tailwindlabs/tailwindcss.com` | v4 |
| NativeWind | resolve `NativeWind` | v4 |
| FastAPI | `/tiangolo/fastapi` | latest |
| Supabase | `/supabase/supabase` | latest |
| OpenAI Agents SDK | resolve `OpenAI Agents` | latest |

## Rule of thumb (goes in rules/common.md)
> Before writing code against Next.js, Expo, Tailwind, FastAPI, Supabase, or the OpenAI SDKs,
> pull the current docs via Context7 for the exact installed version. Do not trust training-data memory.
