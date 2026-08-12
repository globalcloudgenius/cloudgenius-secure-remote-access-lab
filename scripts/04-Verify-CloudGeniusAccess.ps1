#requires -Modules ActiveDirectory
[CmdletBinding()]
param(
    [string[]]$ExpectedGroups = @(
        'CG-Students','CG-Instructors','CG-RDP-DC01','CG-Proxmox-Users',
        'CG-Lab-Admins','CG-VPN-Students','CG-VPN-Instructors','CG-VPN-Admins'
    ),
    [Parameter(Mandatory)][string]$DomainControllerFqdn
)

$ErrorActionPreference = 'Continue'

foreach ($name in $ExpectedGroups) {
    $group = Get-ADGroup -Identity $name -ErrorAction SilentlyContinue
    if ($group -and $group.GroupScope -eq 'Global' -and $group.GroupCategory -eq 'Security') {
        Write-Host "[PASS] $name - Global Security" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] $name is missing or has the wrong type" -ForegroundColor Red
    }
}

$ldap = Test-NetConnection -ComputerName $DomainControllerFqdn -Port 636 -WarningAction SilentlyContinue
if ($ldap.TcpTestSucceeded) {
    Write-Host "[PASS] LDAPS reachable: $DomainControllerFqdn`:636" -ForegroundColor Green
} else {
    Write-Host "[FAIL] LDAPS unreachable: $DomainControllerFqdn`:636" -ForegroundColor Red
}

Resolve-DnsName $DomainControllerFqdn -ErrorAction Continue |
    Select-Object Name,Type,IPAddress

Get-ChildItem Cert:\LocalMachine\My |
    Where-Object {
        $_.HasPrivateKey -and
        $_.EnhancedKeyUsageList.FriendlyName -contains 'Server Authentication' -and
        $_.DnsNameList.Unicode -contains $DomainControllerFqdn
    } |
    Select-Object Subject,Issuer,NotAfter,Thumbprint,HasPrivateKey,
        @{Name='DNSNames';Expression={$_.DnsNameList.Unicode -join ', '}}
