#requires -Modules ActiveDirectory
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][ValidateSet('Student','Instructor')][string]$Role,
    [Parameter(Mandatory)][ValidatePattern('^[a-zA-Z0-9._-]+$')][string]$SamAccountName,
    [Parameter(Mandatory)][string]$GivenName,
    [Parameter(Mandatory)][string]$Surname,
    [Parameter(Mandatory)][string]$DomainDNS,
    [Parameter(Mandatory)][string]$RootOU
)

$ErrorActionPreference = 'Stop'
$displayName = "$GivenName $Surname"
$password = Read-Host "Enter a strong temporary password for $SamAccountName" -AsSecureString

$roleOU = if ($Role -eq 'Student') { 'Students' } else { 'Instructors' }
$roleGroup = "CG-$($Role)s"
$vpnGroup = "CG-VPN-$($Role)s"

if (Get-ADUser -Identity $SamAccountName -ErrorAction SilentlyContinue) {
    throw "The AD account '$SamAccountName' already exists. No changes were made."
}

if ($PSCmdlet.ShouldProcess($SamAccountName, "Create $Role account and grant role/VPN membership")) {
    New-ADUser -Name $displayName -GivenName $GivenName -Surname $Surname `
        -DisplayName $displayName -SamAccountName $SamAccountName `
        -UserPrincipalName "$SamAccountName@$DomainDNS" `
        -Path "OU=$roleOU,$RootOU" -AccountPassword $password `
        -Enabled $true -ChangePasswordAtLogon $true

    Add-ADGroupMember -Identity $roleGroup -Members $SamAccountName
    Add-ADGroupMember -Identity $vpnGroup -Members $SamAccountName
}

Get-ADUser $SamAccountName -Properties Enabled,MemberOf |
    Select-Object Name,SamAccountName,UserPrincipalName,Enabled,
        @{Name='Groups';Expression={$_.MemberOf | ForEach-Object {(Get-ADGroup $_).Name} | Sort-Object}}
