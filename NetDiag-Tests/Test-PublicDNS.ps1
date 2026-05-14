function Test-PublicDNS {
    Update-Progress 30 "Testing Public DNS Resolution..."
    $result = "Public DNS Resolution Test:`r`n"
    $success = $false
    $color = "Red"
    $testDomains = @("google.com", "cloudflare.com")
    
    # Test with Google and Cloudflare DNS servers
    $publicDnsServers = @("8.8.8.8", "1.1.1.1","208.67.222.222")
    foreach ($server in $publicDnsServers) {
        foreach ($domain in $testDomains) {
            try {
                $dnsResult = Resolve-DnsName -Name $domain -Server $server -ErrorAction Stop
                if ($dnsResult) {
                    $result += " - ${domain} resolution (DNS ${server}): PASSED`r`n"
                    $success = $true
                    $color = "Green"
                } else {
                    $result += " - ${domain} resolution (DNS ${server}): FAILED`r`n"
                }
            } catch {
                $result += " - ${domain} resolution (DNS ${server}): FAILED (Error: $_)`r`n"
            }
        }
    }
    Write-OutputBox $result $color
    Update-Progress 100 "Public DNS Test Complete"
    return $success
}