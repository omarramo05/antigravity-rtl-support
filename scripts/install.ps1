# Antigravity RTL Support Installer for Windows
# Description: Automatically injects the dynamic BiDi/RTL rule into your Antigravity environment.

[CmdletBinding()]
param (
    [string]$TargetDir = "$env:USERPROFILE\.gemini\antigravity"
)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "   Antigravity RTL & BiDi Rule Installer (Windows)  " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

$RuleContent = @"

## Dynamic BiDi Rendering & RTL Protocol

- **Language Allocation**:
  - Arabic (or any RTL language) for explanations, trade-offs, and conceptual dialogue.
  - English for all source code, identifiers, function signatures, comments, and technical symbols.

- **Dynamic Text Direction (RTL / LTR Auto-Switching)**:
  - **When communicating in RTL (Arabic/Hebrew/Persian/Urdu)**: Wrap the response inside `<div dir="rtl" style="direction: rtl; text-align: right;">...</div>` so that the desktop chat UI renders text naturally from right to left, with English terms, symbols, and punctuation seated perfectly in place.
  - **When communicating in LTR (English/etc.)**: Output standard markdown without the RTL wrapper, allowing natural left-to-right flow.
"@

# Locate potential rule target locations
$ConfigLocations = @(
    "$env:USERPROFILE\.gemini\config\plugins\omar-global-skills\rules\AGENTS.md",
    "$env:USERPROFILE\.gemini\antigravity\rules\AGENTS.md",
    "$env:USERPROFILE\.gemini\config\rules\AGENTS.md"
)

$Installed = $false

foreach ($loc in $ConfigLocations) {
    if (Test-Path $loc) {
        Write-Host "Found existing rules file: $loc" -ForegroundColor Yellow
        $existing = Get-Content $loc -Raw
        if ($existing -like "*Dynamic BiDi Rendering*") {
            Write-Host "RTL Protocol is already installed in: $loc" -ForegroundColor Green
            $Installed = $true
            break
        } else {
            Add-Content -Path $loc -Value "`n$RuleContent"
            Write-Host "Successfully injected RTL Protocol into: $loc" -ForegroundColor Green
            $Installed = $true
            break
        }
    }
}

if (-not $Installed) {
    # Create a global rule in ~/.gemini/config/rules/AGENTS.md
    $targetPath = "$env:USERPROFILE\.gemini\config\rules\AGENTS.md"
    $targetFolder = Split-Path $targetPath -Parent
    if (-not (Test-Path $targetFolder)) {
        New-Item -ItemType Directory -Path $targetFolder -Force | Out-Null
    }
    Set-Content -Path $targetPath -Value "# Global Operating Rules`n$RuleContent"
    Write-Host "Created new rules file with RTL Protocol at: $targetPath" -ForegroundColor Green
}

Write-Host "`nInstallation Complete! Restart Antigravity or start a new conversation to enjoy native RTL." -ForegroundColor Cyan
