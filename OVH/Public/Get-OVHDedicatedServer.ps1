<#
.SYNOPSIS
.DESCRIPTION
#>
function Get-OVHDedicatedServer {
    [CmdletBinding()]
    param(
    )

    process {

        Test-OVHAuthentication
        $TimeStamp = Get-OVHApiTime
        $URL = "$OVHApiUrl/dedicated/server"
        $Hash = Get-OVHApiHash -Method "GET" -Url $URL  -TimeStamp $TimeStamp
        $Header = Get-OVHHeader -TimeStamp $TimeStamp -Hash $Hash

        Return (Invoke-WebRequest -Uri $URL -Headers $Header -Method GET).Content | ConvertFrom-Json

    }
}
