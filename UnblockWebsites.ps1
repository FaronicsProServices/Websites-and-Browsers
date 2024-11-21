# This script resets the hosts file to its default state on the system. Hence unblocking any URL if previously blocked using the hosts file
$defaultHostsFile = @"

"@

try
{
    $defaultHostsFile | Out-File -FilePath C:\Windows\System32\drivers\etc\hosts -Force -Encoding utf8
    Write-Host "Hosts file updated to default->"
    $defaultHostsFile
}
catch
{
    Write-Host $_.Exception.Message
}
