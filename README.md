# .NET AI Starter — Claude Code + Codex

One shared project memory and workflow for using Claude Code and Codex interchangeably in the same .NET repository.

## Core idea

`AI-GUIDE.md` + `docs/` are the shared source of truth. `CLAUDE.md` and `AGENTS.md` are thin tool-specific adapters.

```text
project/
├── AI-GUIDE.md
├── CLAUDE.md
├── AGENTS.md
├── docs/
│   ├── architecture/
│   ├── decisions/
│   ├── plans/
│   └── ai/
├── .claude/
├── .codex/
└── .agents/
```

## Install

PowerShell:

```powershell
.\install.ps1 -TargetPath C:\Projects\MyApp
```

Default installs both Claude and Codex adapters.

Only Claude:

```powershell
.\install.ps1 -TargetPath C:\Projects\MyApp -Mode Claude
```

Only Codex:

```powershell
.\install.ps1 -TargetPath C:\Projects\MyApp -Mode Codex
```

Preview without writing:

```powershell
.\install.ps1 -TargetPath C:\Projects\MyApp -WhatIf
```

## Existing configurations

The installer is conservative:
- it creates missing files/directories,
- it does not overwrite existing `CLAUDE.md`, `AGENTS.md`, `.claude`, `.codex` or `.agents` content unless `-Force` is specified,
- shared docs templates are added only when missing,
- use `-Backup` with `-Force` to create timestamped backups before replacement.

For projects that already use the separate Claude/Codex starters, install this shared layer first and then merge tool-specific agent/skill packs as needed.

## Switching tools

Before switching Claude → Codex or Codex → Claude, update the active file in `docs/plans/`. The next tool should continue from repository state and the plan instead of relying on chat history.
