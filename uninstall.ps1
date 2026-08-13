[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string]$TargetPath
)

Write-Warning 'This starter intentionally has no automatic destructive uninstall. Remove only files you know were installed by this starter. Existing project files may have been merged or customized.'
