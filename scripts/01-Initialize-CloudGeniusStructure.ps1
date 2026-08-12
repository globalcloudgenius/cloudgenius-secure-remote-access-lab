#requires -Modules ActiveDirectory
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$DomainDN,
    [string]$RootOUName = 'CloudGenius'
)

$ErrorActionPreference = 'Stop'
$rootOU = "OU=$RootOUName,$DomainDN"

function Ensure-OU {
    param([Parameter(Mandatory)][string]$Name, [Parameter(Mandatory)][string]$Path)
    $dn = "OU=$Name,$Path"
    if (-not (Get-ADOrganizationalUnit -Identity $dn -ErrorAction SilentlyContinue)) {
        if ($PSCmdlet.ShouldProcess($dn, 'Create organizational unit')) {
            New-ADOrganizationalUnit -Name $Name -Path $Path -ProtectedFromAccidentalDeletion $true
        }
    }
}

function Ensure-Group {
    param([Parameter(Mandatory)][string]$Name, [Parameter(Mandatory)][string]$Path, [string]$Description)
    if (-not (Get-ADGroup -Filter "SamAccountName -eq '$Name'" -ErrorAction SilentlyContinue)) {
        if ($PSCmdlet.ShouldProcess($Name, 'Create global security group')) {
            New-ADGroup -Name $Name -SamAccountName $Name -GroupScope Global -GroupCategory Security -Path $Path -Description $Description
        }
    }
}

if (-not (Get-ADOrganizationalUnit -Identity $rootOU -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $RootOUName -Path $DomainDN -ProtectedFromAccidentalDeletion $true
}

'Admins','Students','Instructors','Groups','Service Accounts','Servers','Workstations' |
    ForEach-Object { Ensure-OU -Name $_ -Path $rootOU }

Ensure-OU -Name 'Windows Server 2025' -Path "OU=Servers,$rootOU"
Ensure-OU -Name 'Linux Servers' -Path "OU=Servers,$rootOU"
Ensure-OU -Name 'Windows 11' -Path "OU=Workstations,$rootOU"
Ensure-OU -Name 'Linux' -Path "OU=Workstations,$rootOU"

$groupsOU = "OU=Groups,$rootOU"
$groups = @(
    @{ Name='CG-Students'; Description='CloudGenius student role' },
    @{ Name='CG-Instructors'; Description='CloudGenius instructor role' },
    @{ Name='CG-RDP-DC01'; Description='Approved RDP access to AD-DC-01' },
    @{ Name='CG-Proxmox-Users'; Description='Approved Proxmox users' },
    @{ Name='CG-Lab-Admins'; Description='CloudGenius lab administrators' },
    @{ Name='CG-VPN-Students'; Description='Students authorized for SSL VPN' },
    @{ Name='CG-VPN-Instructors'; Description='Instructors authorized for SSL VPN' },
    @{ Name='CG-VPN-Admins'; Description='Administrators authorized for restricted administrative VPN' }
)

foreach ($group in $groups) {
    Ensure-Group -Name $group.Name -Path $groupsOU -Description $group.Description
}

Write-Host '[PASS] CloudGenius OU and group structure is present.' -ForegroundColor Green
