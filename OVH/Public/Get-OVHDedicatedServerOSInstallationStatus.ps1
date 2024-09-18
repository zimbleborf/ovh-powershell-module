<#
.SYNOPSIS
.DESCRIPTION
#>
function Get-OVHDedicatedServerOSInstallationStatus {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True, Position = 0)]
        [string]$Server
    )

    process {
        Test-OVHAuthentication
        $TimeStamp = Get-OVHApiTime
        $URL = "$OVHApiUrl/dedicated/server/$Server/install/status"
        $Hash = Get-OVHApiHash -Method "GET" -Url $URL  -TimeStamp $TimeStamp
        $Header = Get-OVHHeader -TimeStamp $TimeStamp -Hash $Hash
    
        Return ((Invoke-WebRequest -Uri $URL -Headers $Header -Method GET).Content | ConvertFrom-Json).Progress
    }
}
