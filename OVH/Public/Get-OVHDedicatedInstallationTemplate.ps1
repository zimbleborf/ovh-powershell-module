<#
.SYNOPSIS
.DESCRIPTION
#>
function Get-OVHDedicatedInstallationTemplate {
    [CmdletBinding(DefaultParameterSetName = 'Image')]
    param(
        [Parameter(Mandatory=$True, ParameterSetName = 'All')]
        [switch]$All,
        [Parameter(Mandatory=$True, ParameterSetName = 'Image', Position = 0) ]
        [string[]]$Image
    )

    process {

        Test-OVHAuthentication
        $ImageList = @()
        $TimeStamp = Get-OVHApiTime
        If ($All) {

            $URL = "$OVHApiUrl/dedicated/installationTemplate/templateInfos"
            $Hash = Get-OVHApiHash -Method "GET" -Url $URL  -TimeStamp $TimeStamp
            $Header = Get-OVHHeader -TimeStamp $TimeStamp -Hash $Hash

            $ImageList += (Invoke-WebRequest -Uri $URL -Headers $Header -Method GET).Content | ConvertFrom-Json

        }
        Else {
            
            Foreach ($i in $Image) {
            
            $URL = "$OVHApiUrl/dedicated/installationTemplate/$i"
            $Hash = Get-OVHApiHash -Method "GET" -Url $URL  -TimeStamp $TimeStamp
            $Header = Get-OVHHeader -TimeStamp $TimeStamp -Hash $Hash

            $ImageList += (Invoke-WebRequest -Uri $URL -Headers $Header -Method GET).Content | ConvertFrom-Json
            }
        }
    
    Return $ImageList

    }
}
