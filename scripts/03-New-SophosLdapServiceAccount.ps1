#requires -Modules ActiveDirectory
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$SamAccountName = 'svc-sophos-ldap',
    [Parameter(Mandatory)][string]$DomainDNS,
    [Parameter(Mandatory)][string]$Path
)

$ErrorActionPreference = 'Stop'
if (Get-ADUser -Identity $SamAccountName -ErrorAction SilentlyContinue) {
    throw "The account '$SamAccountName' already exists."
}

$password = Read-Host "Enter a domain-compliant password for $SamAccountName" -AsSecureString
if ($PSCmdlet.ShouldProcess($SamAccountName, 'Create least-privileged LDAP bind account')) {
    New-ADUser -Name 'Sophos LDAP Service' -DisplayName 'Sophos LDAP Service' `
        -SamAccountName $SamAccountName -UserPrincipalName "$SamAccountName@$DomainDNS" `
        -Path $Path -AccountPassword $password -Enabled $true `
        -PasswordNeverExpires $true -CannotChangePassword $true `
        -AccountNotDelegated $true `
        -Description 'Least-privileged Sophos Firewall account for AD directory queries'
}

Get-ADUser $SamAccountName -Properties Enabled,PasswordNeverExpires,AccountNotDelegated |
    Select-Object Name,SamAccountName,UserPrincipalName,Enabled,PasswordNeverExpires,AccountNotDelegated

Write-Warning 'Document and schedule password rotation. Update the Sophos external server immediately after rotation.'
