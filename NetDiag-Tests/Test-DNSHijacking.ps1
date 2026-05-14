function Test-DSNHijacking {
    Update-Progress 35 "Testing Public DNS HiJacking..."
    $success = $false
    $color = "Red"    
    
    # Test for DNS hijacking with fake DNS server
    $fakeServer = "10.0.0.0"
    $validHost = "google.com"
    $result += " - DNS Hijacking Test (Fake Server ${fakeServer}):`r`n"
    try {
        Resolve-DnsName -Server $fakeServer -QuickTimeout -DnsOnly -Name $validHost -ErrorAction Stop
        $result += "   - DNS Hijacking DETECTED (e.g., Xfinity SecurityEdge or similar)`r`n"
        $color = "Red"
    } catch [System.ComponentModel.Win32Exception] {
        if ($_.FullyQualifiedErrorId -and $_.FullyQualifiedErrorId.StartsWith("ERROR_TIMEOUT")) {
            $result += "   - DNS Hijacking NOT detected: PASSED`r`n"
            $success = $true
            $color = if ($success) { "Green" } else { "Red" }
        } else {
            $result += "   - Error: $($_.FullyQualifiedErrorId)`r`n"
        }
    } catch {
        $result += "   - Unknown error during hijacking test: $($_.Exception.GetType().FullName)`r`n"
    }
    
    Write-OutputBox $result $color
    Update-Progress 100 "DNS HiJacking Test Complete."
    return $success
}