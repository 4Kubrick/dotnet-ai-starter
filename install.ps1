[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetPath,

    [ValidateSet('Both','Claude','Codex')]
    [string]$Mode = 'Both',

    [switch]$Force,
    [switch]$Backup
)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$TargetPath = [System.IO.Path]::GetFullPath($TargetPath)

if (-not (Test-Path $TargetPath)) {
    throw "Target path does not exist: $TargetPath"
}

function Backup-ItemIfNeeded {
    param([string]$Path)
    if ($Backup -and (Test-Path $Path)) {
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $backupPath = "$Path.ai-starter-backup-$stamp"
        if ($PSCmdlet.ShouldProcess($backupPath, "Create backup of $Path")) {
            Copy-Item -LiteralPath $Path -Destination $backupPath -Recurse -Force
        }
    }
}

function Copy-FileSafe {
    param([string]$Source, [string]$Destination)
    $parent = Split-Path -Parent $Destination
    if (-not (Test-Path $parent)) {
        if ($PSCmdlet.ShouldProcess($parent, 'Create directory')) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
    }

    if (Test-Path $Destination) {
        if (-not $Force) {
            Write-Host "SKIP existing: $Destination"
            return
        }
        Backup-ItemIfNeeded $Destination
    }

    if ($PSCmdlet.ShouldProcess($Destination, "Copy $Source")) {
        Copy-Item -LiteralPath $Source -Destination $Destination -Force
        Write-Host "INSTALLED: $Destination"
    }
}

function Copy-TreeMerge {
    param([string]$SourceRoot, [string]$DestinationRoot)
    Get-ChildItem -LiteralPath $SourceRoot -File -Recurse | ForEach-Object {
        $relative = $_.FullName.Substring($SourceRoot.Length).TrimStart('\\','/')
        Copy-FileSafe $_.FullName (Join-Path $DestinationRoot $relative)
    }
}

Write-Host "Installing .NET AI Starter into $TargetPath (Mode=$Mode)"

# Shared source of truth
Copy-FileSafe (Join-Path $Root 'shared/AI-GUIDE.md') (Join-Path $TargetPath 'AI-GUIDE.md')
Copy-TreeMerge (Join-Path $Root 'shared/docs') (Join-Path $TargetPath 'docs')

if ($Mode -in @('Both','Claude')) {
    Copy-FileSafe (Join-Path $Root 'claude/CLAUDE.md') (Join-Path $TargetPath 'CLAUDE.md')
    Copy-TreeMerge (Join-Path $Root 'claude/.claude') (Join-Path $TargetPath '.claude')
}

if ($Mode -in @('Both','Codex')) {
    Copy-FileSafe (Join-Path $Root 'codex/AGENTS.md') (Join-Path $TargetPath 'AGENTS.md')
    Copy-TreeMerge (Join-Path $Root 'codex/.codex') (Join-Path $TargetPath '.codex')
    Copy-TreeMerge (Join-Path $Root 'codex/.agents') (Join-Path $TargetPath '.agents')
}

Write-Host ''
Write-Host 'Done.'
Write-Host 'Next:'
Write-Host '1. Customize AI-GUIDE.md for the project.'
Write-Host '2. Keep active work in docs/plans/.'
Write-Host '3. Record durable decisions in docs/decisions/.'
Write-Host '4. Merge any richer Claude/Codex agent packs you already use.'
