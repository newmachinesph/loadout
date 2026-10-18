# RTK - Rust Token Killer

**Usage:** token-optimized CLI proxy (60-90% savings on dev operations).

## Meta commands (always use rtk directly)
```bash
rtk gain              # Show token savings analytics
rtk gain --history    # Show command usage history with savings
rtk discover          # Analyze Claude Code history for missed opportunities
rtk proxy <cmd>       # Execute raw command without filtering (for debugging)
```

## Installation verification
```bash
rtk --version         # Should show: rtk X.Y.Z
rtk gain              # Should work (not "command not found")
where.exe rtk         # Verify the correct binary is on PATH (Windows)
```

**Name collision:** if `rtk gain` fails, you may have `reachingforthejack/rtk` (Rust Type Kit) installed instead of the token killer.

## Hook-based usage
All other commands are rewritten automatically by the Claude Code `PreToolUse:Bash` hook.
Example: `git status` → `rtk git status` (transparent, 0 tokens overhead). RTK only filters the Bash tool; Read/Grep/Glob bypass it.
