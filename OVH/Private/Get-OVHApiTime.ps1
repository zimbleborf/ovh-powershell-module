<#
.SYNOPSIS
.DESCRIPTION
#>
function Get-OVHApiTime {
    [CmdletBinding()]
    param(
    )

    process {

        $CurrentTime = [math]::Round((Get-Date -Date (Get-Date).ToUniversalTime() -UFormat %s))

        If ($OVHTimeDelta) {
            Write-Verbose "Using Time Delta from cache."
        }
        Else {
            Write-Verbose "Getting Time Delta from server."
            $ApiTime = Invoke-WebRequest -Uri $OVHApiUrl/auth/time -Method 'GET' | ConvertFrom-Json
            $global:OVHTimeDelta = $CurrentTime - $ApiTime
        }

        Return $CurrentTime - $OVHTimeDelta

    }
}
