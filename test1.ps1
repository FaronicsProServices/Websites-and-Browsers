# 1. Define Standard Paths
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$publicDesktop = [Environment]::GetFolderPath("CommonDesktopDirectory")
$shortcutName = "Chrome (T-Drive).lnk"
$destinationPath = Join-Path $publicDesktop $shortcutName
$arguments = '--user-data-dir="T:\Chrome\User Data"'

# 2. Verify Chrome Installation
if (-not (Test-Path $chromePath)) {
    Write-Error "Chrome executable not found at $chromePath. Deployment aborted."
    exit 1
}

# 3. Logic: Check for existing shortcut or create new one
if (Test-Path $destinationPath) {
    Write-Output "Shortcut already exists at $destinationPath. Skipping creation."
} else {
    try {
        Write-Output "Creating shortcut for Chrome with T-Drive redirection..."
        
        $shell = New-Object -ComObject WScript.Shell
        $shortcut = $shell.CreateShortcut($destinationPath)
        $shortcut.TargetPath = $chromePath
        $shortcut.Arguments = $arguments
        $shortcut.WorkingDirectory = "C:\Program Files\Google\Chrome\Application"
        $shortcut.Description = "Launch Chrome using T: Drive for User Data"
        $shortcut.IconLocation = "$chromePath,0"
        $shortcut.Save()
        
        Write-Output "Success: Shortcut created on Public Desktop."
    } catch {
        Write-Error "Failed to create shortcut: $($_.Exception.Message)"
        exit 1
    }
}
