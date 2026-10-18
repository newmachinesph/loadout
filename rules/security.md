# security rules

- **No secrets in code or git.** Env vars + `.env` (gitignored). Rotate anything exposed.
- **Supabase keys:** `service_role` server-only; `anon` client-only; RLS enabled on every table.
- **OpenAI key** server-only — never ship it to the Expo/Next client bundle.
- Validate all boundary input; parameterized queries; escape/sanitize output (no `dangerouslySetInnerHTML` on unsanitized data).
- Auth: verify JWT server-side on protected routes.
- Automated backstop: `safety-hooks` plugin + ECC `security-scan` (AgentShield) catch secrets/dangerous commands — don't rely on them alone.
