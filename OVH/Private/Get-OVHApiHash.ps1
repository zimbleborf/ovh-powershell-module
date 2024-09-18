<#
.SYNOPSIS
.DESCRIPTION
#>
function Get-OVHApiHash {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$Method,
        [string]$Url,
        [string]$TimeStamp,
        [string]$Body
    )

    process {

        $SHA1 = New-Object System.Security.Cryptography.SHA1Managed

        $Key = "$($OVHCredential.GetNetworkCredential().Password)+$OVHConsumerKey+$Method+$Url+$Body+$TimeStamp"
        $Hash = $SHA1.ComputeHash([Text.Encoding]::ASCII.GetBytes($Key))
        $Hex = [string]::Join("", ($Hash | ForEach-Object { $_.ToString('x2')}))

        Return "`$1`$$Hex"

    }
}