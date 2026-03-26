# 1. Configuration
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$shortcutName = "Google Chrome.lnk"
$publicDesktop = [Environment]::GetFolderPath("CommonDesktopDirectory")
$destinationPath = Join-Path $publicDesktop $shortcutName
$targetArguments = '--user-data-dir="T:\Chrome\User Data"'

# 2. Check if Chrome is installed
if (-not (Test-Path $chromePath)) {
    Write-Output "Chrome executable not found. Deployment skipped."
    exit 0
}

# 3. Create or Modify Logic
try {
    $shell = New-Object -ComObject WScript.Shell
    
    if (Test-Path $destinationPath) {
        Write-Output "Existing shortcut found. Updating Target path..."
    } else {
        Write-Output "No shortcut found. Creating new 'Google Chrome' shortcut..."
    }

    # This command handles both: if it exists, it opens it; if not, it initializes a new one
    $shortcut = $shell.CreateShortcut($destinationPath)
    
    # Apply the specific Target and Arguments
    $shortcut.TargetPath = $chromePath
    $shortcut.Arguments = $targetArguments
    $shortcut.WorkingDirectory = "C:\Program Files\Google\Chrome\Application"
    $shortcut.Description = "Google Chrome"
    $shortcut.IconLocation = "$chromePath,0"
    
    # Save the changes (Overwrites if exists, Creates if new)
    $shortcut.Save()
    
    Write-Output "Success: Shortcut at $destinationPath is now pointing to T:\ drive data."
} catch {
    Write-Error "Failed to process shortcut: $($_.Exception.Message)"
    exit 1
}
