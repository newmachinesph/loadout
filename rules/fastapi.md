# FastAPI + Pydantic v2 + Supabase

Verify against Context7 (`/tiangolo/fastapi`, `/supabase/supabase`) before coding.

## FastAPI
- `async def` endpoints; `Depends()` for injection (auth, db session).
- Pydantic **v2**: `model_validate()`, `model_dump()`, `Field()`, `model_config`. (Not v1 `.dict()`/`.parse_obj()`.)
- Config via `pydantic-settings` (`BaseSettings`) reading env vars.

## Supabase (Postgres + Auth)
- **RLS on every table.** Verify policies exist before shipping.
- **service_role key = server-only**, never sent to client. Client uses anon key.
- Validate Supabase Auth JWT on protected routes.
- Prefer Supabase client / parameterized queries — no string-built SQL.
