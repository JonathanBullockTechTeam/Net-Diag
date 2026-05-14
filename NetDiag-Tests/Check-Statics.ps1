
function Check-StaticIPs {
    #check if there is a static Reserved IP
    Update-progress (Get-Random -Minimum 10 -Maximum 40) "Checking for local Static IP's"
    $ManualIPs = (Get-NetIPAddress | where SuffixOrigin -EQ Manual | ft ipaddress -HideTableHeaders | Out-String -Width 250).Trim()
    if ($ManualIPs.Length -eq 0) {
        Write-OutputBox -Color "Green" -Text "No Static IP"}
        else{ Write-OutputBox -Color "red" -Text "Primary Interface is a Static IP"}

      Update-progress (Get-Random -Minimum 10 -Maximum 40) "Checking for static local DNS...)"

    #check if the DNS Is set static Seperate of DHCP
    Update-progress (Get-Random -Minimum 30 -Maximum 60) "Checking for local Static DNS..."
    function Check-StaticDNS {
        $StaticDNSSearch = (netsh int ip show dnsservers) | Select-String "Statically" | Where-Object { $_.Line -notlike "*None*" }
        if ($StaticDNSSearch -ne $null){
        $results = ($StaticDNSSearch.ToString()).Trim()}
        return $results
    }
    #Prepend 
    $StaticDNS = Check-StaticDNS
    $StaticDNS
    if (($StaticDNS).Length -ne 0) {
    Write-OutputBox -Color "Red" -Text "There for Static DNS settings."
    Write-OutputBox -Color "Black" -Text "There are special cases where DNS may be set manually but if done on portable devices this may break internet connectivity when moving networks."
    Write-OutputBox -Color "Black" -Text "Check with your Network administrators if a DHCP Reservation could be used instead of a local static."
        }
Update-progress 100 "Done Checking for local Static settings."
}
