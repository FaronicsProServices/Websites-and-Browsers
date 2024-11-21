# This script will stop specified websites from loading on browser
$blockUrlList = @("www.facebook.com", "www.google.com", "www.youtube.com") 


$defaultHostsFile = @"

"@

try
{
    $originalhostsFile= Get-Content C:\Windows\System32\drivers\etc\hosts -ErrorAction Ignore
    $hostFileExists = $true
    if(-not($originalhostsFile))
    {
        $hostFileExists = $false
        $originalhostsFile = $defaultHostsFile
    }
    $updatedHostsFile = $originalhostsFile
    ForEach($url in $blockUrlList)
    {
        if($hostFileExists)
        {
            $updatedHostsFile = $updatedHostsFile+"127.0.0.1 $url"
        }
        else
        {
            $updatedHostsFile = $updatedHostsFile+"`n127.0.0.1 $url"
        }

    }
    $updatedHostsFile | Out-File -FilePath C:\Windows\System32\drivers\etc\hosts -Encoding utf8 -Force
    Write-Host "updated Hosts file->"
    $updatedHostsFile
}
catch
{
    Write-Host $_.Exception.Message
}
