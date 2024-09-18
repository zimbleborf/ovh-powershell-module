<#
.SYNOPSIS
.DESCRIPTION
#>
function Get-OVHHeader {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [double]$TimeStamp,
        [string]$Hash


    )

    process {

        $Header = @{
            "accept" = "application/json"
            "X-Ovh-Application" = $OVHApplicationKey
            "X-Ovh-Timestamp" = $TimeStamp
            "X-Ovh-Signature" = $Hash
            "X-Ovh-Consumer" = $OVHConsumerKey
        }

        Return $Header

    }
}
