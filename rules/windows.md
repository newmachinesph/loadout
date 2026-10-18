# Windows rules (all projects)

Windows-only by design — everything assumes Windows 11 + PowerShell. No WSL required.

## Repos & filesystem
- **Keep active repos out of OneDrive/Dropbox-synced folders** — sync locks fight git and `node_modules` churn. Prefer `C:\dev`. If a repo must stay synced, pause sync during heavy installs/builds.
- Enable long paths once (deep `node_modules` exceed the 260-char `MAX_PATH`):
  `git config --global core.longpaths true` and set `LongPathsEnabled` in the registry.
- One line-ending policy, committed with the repo: `git config --global core.autocrlf false` + `.gitattributes` with `* text=auto eol=lf`.
- Add **Defender exclusions** for `node_modules`, `.next`, `.expo`, `.venv`, and build output dirs — large install/build speedups.

## PowerShell (5.1 is the default shell)
- No `&&` / `||`, no ternary — use `A; if ($?) { B }`. Native since Win10: `curl.exe`, `tar.exe`, `where.exe` (not `which`).
- `Out-File` / `Set-Content` default to **UTF-16** — pass `-Encoding utf8` for files other tools read.
- Scripts blocked? Once: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`.
- Multi-line strings to native exes: single-quoted here-strings, closing `'@` at column 0 — see `git.md`.

## Dev servers (this stack)
- First run of Metro/Expo (8081), Next (3000), or FastAPI (8000) triggers a **Windows Firewall prompt** — allow **Private** networks or a physical device can't reach the LAN dev server.
- Android emulator: `adb reverse tcp:8081 tcp:8081` (Metro) and `adb reverse tcp:8000 tcp:8000` (API) beat juggling LAN IPs.
- Physical device on LAN: use the machine's IPv4 from `ipconfig`, not `localhost`, in Expo/API URLs.
