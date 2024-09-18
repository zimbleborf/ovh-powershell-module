<#
.SYNOPSIS
.DESCRIPTION
#>
function Get-OVHDedicatedServerHardware {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True, Position=0)]
        [string[]]$Server
    )

    process {

        $ServerList = @()
        Foreach ($i in $Server) {
            Test-OVHAuthentication
            $TimeStamp = Get-OVHApiTime
            $URL = "$OVHApiUrl/dedicated/server/$i/specifications/hardware"
            $Hash = Get-OVHApiHash -Method "GET" -Url $URL  -TimeStamp $TimeStamp
            $Header = Get-OVHHeader -TimeStamp $TimeStamp -Hash $Hash
            
            $ServerList += (Invoke-WebRequest -Uri $URL -Headers $Header -Method GET).Content | ConvertFrom-Json

        }
        Return $ServerList


    }
}
