# loadout setup (Windows / Claude Code)
# Reproduces the foundation on a new machine. Run from the loadout folder.
# Prereqs: Node 18+, Git. (Bun optional.)
# Usage:  .\setup.ps1              full install (ECC, RTK, Caveman, claude-mem, rules, CLAUDE.md)
#         .\setup.ps1 -RulesOnly   rule packs + CLAUDE.md only — no external tools
param([switch]$RulesOnly)
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot

if (-not $RulesOnly) {
Write-Host "== 1. ECC (base harness, minimal) ==" -ForegroundColor Cyan
npx -y -p ecc-universal ecc-install --profile minimal --target claude

Write-Host "== 2. RTK (token compressor) ==" -ForegroundColor Cyan
$bin = "$env:USERPROFILE\.local\bin"; New-Item -ItemType Directory -Force $bin | Out-Null
$rel = Invoke-RestMethod -Headers @{'User-Agent'='setup'} https://api.github.com/repos/rtk-ai/rtk/releases/latest
$url = ($rel.assets | Where-Object name -eq 'rtk-x86_64-pc-windows-msvc.zip').browser_download_url
$zip = "$env:TEMP\rtk.zip"; curl.exe -fsSL -o $zip $url
tar.exe -xf $zip -C $bin
if (Test-Path "$env:USERPROFILE\.bun\bin") { Copy-Item "$bin\rtk.exe" "$env:USERPROFILE\.bun\bin\rtk.exe" -Force }  # on PATH so the hook resolves
$p = [Environment]::GetEnvironmentVariable('Path','User'); if ($p -notlike "*$bin*") { [Environment]::SetEnvironmentVariable('Path', "$p;$bin",'User') }
& "$bin\rtk.exe" init -g   # accept the settings.json patch when prompted

Write-Host "== 3. Caveman (terse mode, core skill only) ==" -ForegroundColor Cyan
npx -y skills add JuliusBrussee/caveman -g -a claude-code -s caveman -y

Write-Host "== 4. claude-mem (persistent memory) ==" -ForegroundColor Cyan
npx -y claude-mem install
}

Write-Host "== 5. copy rule packs + loadout profiles -> ~/.claude/rules/loadout ==" -ForegroundColor Cyan
$dst = "$env:USERPROFILE\.claude\rules\loadout"; New-Item -ItemType Directory -Force $dst | Out-Null
Copy-Item "$root\rules\*" $dst -Recurse -Force

Write-Host "== 6. global instructions (CLAUDE.md + RTK.md) ==" -ForegroundColor Cyan
$claudeDir = "$env:USERPROFILE\.claude"
$claudeMd = "$claudeDir\CLAUDE.md"
if (Test-Path $claudeMd) {
  Copy-Item $claudeMd "$claudeDir\CLAUDE.backup.md" -Force
  Write-Host "  Existing CLAUDE.md backed up -> $claudeDir\CLAUDE.backup.md" -ForegroundColor Yellow
}
Copy-Item "$root\CLAUDE.md" $claudeMd -Force
Copy-Item "$root\RTK.md"    "$claudeDir\RTK.md" -Force
Write-Host "  Installed CLAUDE.md + RTK.md. Edit CLAUDE.md to fill in your stack (see CLAUDE.example.md)."

Write-Host ""
if ($RulesOnly) {
  Write-Host "Rules-only install done. Fill in CLAUDE.md (see CLAUDE.example.md), then restart Claude Code." -ForegroundColor Green
} else {
  Write-Host "MANUAL: run in a terminal (needs the claude CLI: npm i -g @anthropic-ai/claude-code):" -ForegroundColor Yellow
  Write-Host "  claude plugin marketplace add poshan0126/dotclaude   ; claude plugin install safety-hooks@dotclaude"
  Write-Host "  claude plugin marketplace add DietrichGebert/ponytail; claude plugin install ponytail@ponytail"
  Write-Host "  claude plugin marketplace add upstash/context7       ; claude plugin install context7"
  Write-Host "  npx claude-mem start"
  Write-Host "  (the /plugin chat command is NOT available in the VS Code extension - use the CLI)"
  Write-Host "Done. Restart Claude Code to activate everything."
}
