function Test-SystemDNS {
    Update-Progress 30 "Testing Local DNS Resolution..."
    $result = "Public DNS Resolution Test:`r`n"
    $success = $false
    $color = "Red"
    $testDomains = @("google.com", "cloudflare.com")
    
    # Test with default system DNS
    foreach ($domain in $testDomains) {
        try {
            $dnsResult = [System.Net.Dns]::GetHostAddresses($domain)
            if ($dnsResult) {
                $result += " - ${domain} resolution (System DNS): PASSED`r`n"
                $success = $true
                $color = "Green"
            } else {
                $result += " - ${domain} resolution (System DNS): FAILED`r`n"
            }
        } catch {
            $result += " - ${domain} resolution (System DNS): FAILED`r`nError: $_`r`n"
        }
    }
    Write-OutputBox $result $color
    Update-Progress 100 "Public DNS Test Complete"
    return $success
}