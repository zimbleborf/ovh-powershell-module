<#
.SYNOPSIS
.DESCRIPTION
#>
function Get-OVHDedicatedInstallCompatibleTemplates {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string[]]$Server
    )

    process {

        $ServerList = @()
        Foreach ($i in $Server) {
            Test-OVHAuthentication
            $TimeStamp = Get-OVHApiTime
            $URL = "$OVHApiUrl/dedicated/server/$i/install/compatibleTemplates"
            $Hash = Get-OVHApiHash -Method "GET" -Url $URL  -TimeStamp $TimeStamp
            $Header = Get-OVHHeader -TimeStamp $TimeStamp -Hash $Hash
            
            $Request = (Invoke-WebRequest -Uri $URL -Headers $Header -Method GET).Content | ConvertFrom-Json

            $ServerList += New-Object PSCustomObject -Property @{

                Server = $i
                OVHImages = $Request.OVH
                PersonalImages = $Request.Personal

            }

        }
        Return $ServerList

    }
}
