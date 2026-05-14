Write-OutputBox "Scanning Event Logs for DHCP Error IDs: 1000,1001,1002,1003" Black
Update-Progress 10 "Local Gateway Test Complete"

$events = Get-WinEvent -FilterHashtable @{
    ProviderName = 'Microsoft-Windows-Dhcp-Client'
    #ID = 1000,1001,1002,1003
    Level = 1,2
    StartTime = (Get-Date).AddDays(-3)
} -ErrorAction SilentlyContinue

write-host '<-Start Result->' 
$events | Select-Object -First 1 | fl TimeCreated, message | Out-String
write-host '<-End Result->' 

if ($events.Count -gt 0){
    #return Error Status
    }
else{#return Good Status
    }

Write-OutputBox $result $color
Update-Progress 100 "Local Gateway Test Complete"