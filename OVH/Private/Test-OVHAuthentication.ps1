<#
.SYNOPSIS
.DESCRIPTION
#>
function Test-OVHAuthentication {
    [CmdletBinding()]
    param(
    )

    process {

        Write-Verbose "Testing OVH Authentication details."
        If (-not ($OVHApplicationKey -and $OVHApplicationSecret -and $OVHConsumerKey -and $OVHApiUrl -and $OVHCredential)) {

            Throw "OVH Application Key, Application Secret, Consumer Key, and/or API URL aren't set. Run Set-OVHAuthentication first."

        }
        Else {

            Write-Verbose "OVH Authentication details found. Continuing."

        }
    }
}
