<#
.SYNOPSIS
.DESCRIPTION
#>
function Start-OVHDedicatedServerOSInstallation {
    [CmdletBinding(DefaultParameterSetName = 'Server', SupportsShouldProcess = $True)]
    param(
        [Parameter(Mandatory=$True, ParameterSetName = 'Server', Position = 0)]
        [string]$Server,
        [Parameter(Mandatory=$True, ParameterSetName = 'Server', Position = 1)]
        [string]$Image,
        [Parameter(Mandatory=$False, ParameterSetName = 'Server')]
        [int]$DiskGroupID,
        [string]$CustomHostName,
        [hashtable]$UserMetaData,
        [boolean]$NoRaid,
        [string]$PostInstallationScriptLink,
        [string]$PostInstallationScriptReturn,
        [int]$SoftRaidDevices,
        [string]$SSHKeyName,
        [string]$PartitionSchemeName
    )

    process {

        Test-OVHAuthentication
        $TimeStamp = Get-OVHApiTime
        $URL = "$OVHApiUrl/dedicated/server/$Server/install/start"
        $Body = @{
            "templateName" = $Image
        }
        If ($CustomHostName -or $DiskGroupID -or $NoRaid -or $PostInstallationScriptLink -or $PostInstallationScriptReturn -or $SoftRaidDevices -or $SSHKeyName) {

            $Body.Add("details", @{})
            
            If ($CustomHostName) {$Body.details.Add("customHostname", $CustomHostName)}
            If ($DiskGroupID) {$Body.details.Add("diskGroupId", $DiskGroupID)}
            If ($NoRaid) {$Body.details.Add("noRaid", $True)}
            If ($PostInstallationScriptLink) {$Body.details.Add("postInstallationScriptLink", $PostInstallationScriptLink)}
            If ($PostInstallationScriptReturn) {$Body.details.Add("postInstallationScriptReturn", $PostInstallationScriptReturn)}
            If ($SSHKeyName) {$Body.details.Add("sshKeyName", $SSHKeyName)}
        }
        If ($PartitionSchemeName) {$Body.Add("partitionSchemeName", $PartitionSchemeName)}
        If ($UserMetaData) {
            $Body.Add("userMetaData", $UserMetaData)
    }

        $Hash = Get-OVHApiHash -Method "POST" -Url $URL -Body ($Body | ConvertTo-Json) -TimeStamp $TimeStamp
        $Header = Get-OVHHeader -TimeStamp $TimeStamp -Hash $Hash

        If ($PSCmdlet.ShouldProcess($Server, "Starting OS installation with following variables $($Body | ConvertTo-Json) and $($Header | ConvertTo-Json)")) {

            $Request = Invoke-WebRequest -Headers $Header -Method Post -Body ($Body | ConvertTo-Json) -Uri $URL -ContentType application/json

            Return $Request.Content | ConvertFrom-Json

        }


    }
}
