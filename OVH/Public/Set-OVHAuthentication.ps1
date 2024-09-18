<#
.SYNOPSIS
.DESCRIPTION
#>
function Set-OVHAuthentication {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$ApplicationKey,
        [securestring]$ApplicationSecret,
        [string]$ConsumerKey,
        [string]$ApiUrl
    )

    process {

        $global:OVHApplicationKey = $ApplicationKey
        $global:OVHApplicationSecret = $ApplicationSecret
        $global:OVHConsumerKey = $ConsumerKey
        $global:OVHApiUrl = $ApiUrl.TrimEnd('/')
        $global:OVHCredential = [PSCredential]::New($ApplicationKey,$ApplicationSecret)

    }
}
