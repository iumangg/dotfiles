# Check if oh-my-posh is installed
if (-not (Get-Command "oh-my-posh" -ErrorAction SilentlyContinue)) {
    Write-Host "Installing oh-my-posh..."
    Install-Module oh-my-posh -Scope CurrentUser -Force
}

$sysProfilePath = $PROFILE
$curProfilePath = Join-Path (Split-Path -Path $MyInvocation.MyCommand.Path) "profile.ps1"

# Delete the existing profile if it exists
if (Test-Path $sysProfilePath) {
    Remove-Item -Path $sysProfilePath -Force
    Write-Host "Deleted existing profile at $sysProfilePath"
}

# Create a symlink from the current profile to the system profile
if (Test-Path $curProfilePath) {
    New-Item -ItemType SymbolicLink -Path $sysProfilePath -Target $curProfilePath -Force
    Write-Host "Created symlink from $curProfilePath to $sysProfilePath"
} 

$sysPromptPath = Join-Path (Split-Path -Path $PROFILE) "prompt.ps1"
$curPromptPath = Join-Path (Split-Path -Path $MyInvocation.MyCommand.Path) "prompt.ps1"

# Delete the existing prompt if it exists
if (Test-Path $sysPromptPath) {
    Remove-Item -Path $sysPromptPath -Force
    Write-Host "Deleted existing prompt at $sysPromptPath"
}

# Create a symlink from the current prompt to the system prompt
if (Test-Path $curPromptPath) {
    New-Item -ItemType SymbolicLink -Path $sysPromptPath -Target $curPromptPath -Force
    Write-Host "Created symlink from $curPromptPath to $sysPromptPath"
}

Write-Host "PowerShell setup complete, dotfiles installed successfully."