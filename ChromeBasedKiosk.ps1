# This script schedules a task to run a Chrome-based website kiosk mode for the specified user upon logon, by killing explorer.exe and launching Chrome in kiosk mode.
try{ 
         Write-Host "Scheduling website kiosk for user" 
         $username = "walter" 
         # Unregister any existing task with the same name from task scheduler 
         try 
         { 
           $a=Unregister-ScheduledTask -TaskName 'TaskName' -Confirm:$false -ErrorAction:Ignore 
         } 
         catch 
         { 
           Write-Host "Error while unregistering schedule task-->",$_.Exception.Message 
         } 
         #scheduling task 
         $action1 = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument 'taskkill /f /im explorer.exe' 
         $action2 = New-ScheduledTaskAction -Execute 'C:\Program Files\Google\Chrome\Application\chrome.exe' -Argument '-kiosk https://www.faronics.com/en-uk' 
         $actions = @($action1, $action2) 
         $principal = New-ScheduledTaskPrincipal -UserId $username -RunLevel Highest 
         $trigger = New-ScheduledTaskTrigger -AtLogon -User $username  
         $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries  
         $task = New-ScheduledTask -Action $actions -Principal $principal -Settings $settings -Trigger $trigger 
         $reg= Register-ScheduledTask 'TaskName' -InputObject $task 
} 
catch 
{ 
    Write-Host "Exception inside running script-->",$_.Exception.Message 
}  
