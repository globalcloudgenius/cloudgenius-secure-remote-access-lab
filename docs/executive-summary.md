# Executive and business summary

## Director-level result

CloudGenius moved from individually managed firewall/VPN identities toward a centralized, auditable access model tied to Active Directory. Users can be placed into business-aligned AD groups, and Sophos can use those groups to determine which remote-access policy applies.

## Business value

1. **Faster onboarding and offboarding** — access is granted or removed by changing AD group membership rather than maintaining separate identities on multiple systems.
2. **Reduced credential risk** — the Sophos-to-AD directory connection is encrypted with LDAPS and validates the domain controller certificate against the CloudGenius internal CA.
3. **Clear separation of duties** — students, instructors, and administrators use different security groups and can receive different network permissions.
4. **Improved auditability** — authentication, group membership, VPN assignment, and firewall activity can be traced to named directory identities.
5. **Scalable lab operations** — Windows 11, Linux, and Windows Server 2025 systems can be added behind the same identity and network-control framework.
6. **Lower operational duplication** — AD becomes the source of truth instead of duplicating every user in Sophos.
7. **Safer remote learning** — split tunneling and explicitly permitted resources reduce unnecessary exposure while preserving access to approved lab services.

## Control objectives achieved

- Central identity source established in the lab AD domain.
- Least-privileged Sophos directory service account created.
- Enterprise PKI established for internal certificate trust.
- Domain controller certificate issued with the correct FQDN and server-authentication purpose.
- Certificate-validated LDAPS tested successfully on TCP 636.
- Sophos AD integration tested successfully.
- AD VPN groups imported into Sophos.
- Student and instructor VPN policies separated.
- A fresh AD user and fresh client profile successfully established an SSL/TCP VPN tunnel.

## Remaining governance actions

- Enable MFA for remote-access users.
- Complete migration away from duplicate Sophos-local user accounts.
- Restrict student resources to exact hosts/services instead of broad LAN access.
- Create a dedicated administrative VPN policy; do not mix it with student or instructor access.
- Add a second domain controller/DNS server before treating the design as production resilient.
- Define certificate renewal, CA backup, firewall backup, log retention, and access review schedules.
- Remove unnecessary standing membership from highly privileged AD groups.

## Success measures

- 100% of VPN users authenticate through AD rather than local Sophos accounts.
- 100% of VPN groups have an identified owner and documented purpose.
- MFA coverage reaches 100% for remote access.
- Quarterly group-access reviews show no stale student or instructor accounts.
- Certificate expiration monitoring provides at least 30 days of warning.
- Student policies expose only approved lab destinations and services.
