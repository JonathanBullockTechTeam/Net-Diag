
    function Check-DHCPErrors{
    Write-OutputBox "Scanning Event Logs for DHCP Error IDs: 1000,1001,1002,1003" Black
    Update-Progress 10 "Checking Event Logs for DHCP Errors..."

    $events = Get-WinEvent -FilterHashtable @{
        ProviderName = 'Microsoft-Windows-Dhcp-Client'
        #ID = 1000,1001,1002,1003
        Level = 1,2
        StartTime = (Get-Date).AddDays(-3)
    } -ErrorAction SilentlyContinue
      Update-Progress 20 "Checking Event Logs for DHCP Errors..."
    write-host '<-Start Result->' 
    $events | Select-Object -First 1 | fl TimeCreated, message | Out-String
    write-host '<-End Result->' 

    if ($events.Count -gt 0){
        #return Error Status
        Write-OutputBox "----  DHCP Errors were found in local log  ----" Red
        Write-OutputBox $events Black
        }
    else{#return Good Status
        Write-OutputBox "No DHCP Errors Found" Green
        }
    Update-Progress 100 "Done Scanning for DHCP Errors."
}