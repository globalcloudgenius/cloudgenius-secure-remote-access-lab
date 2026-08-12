# CloudGenius Secure Remote Access

Technical and business record of the CloudGenius Active Directory, PKI, LDAPS, Sophos Firewall, and SSL VPN integration completed on **August 11, 2026**.

## Outcome

CloudGenius now has centralized identity-backed VPN access. Sophos Firewall authenticates users against on-premises Active Directory over certificate-validated LDAPS, maps imported AD security groups to separate student and instructor SSL VPN policies, and provides split-tunnel access to approved lab resources.

The end-to-end design was validated with a fresh AD test user and a newly downloaded Sophos Connect profile. A successful SSL/TCP tunnel confirmed that the identity, certificate trust, group mapping, VPN policy, and client configuration worked together.

## Documentation

- [Executive and business summary](docs/executive-summary.md)
- [Technical implementation record](docs/implementation-record.md)
- [Student and instructor operating procedure](docs/student-onboarding.md)
- [Learning outcomes and practical exercises](docs/learning-outcomes.md)
- [Security hardening and operations](docs/security-hardening.md)
- [Reusable PowerShell scripts](scripts/)

## Current logical design

| Component | Name/address | Purpose |
| --- | --- | --- |
| Sophos Firewall | `10.10.10.1`; WAN represented as `203.0.113.10` | Policy enforcement, VPN gateway, authentication broker |
| Domain controller | `DC01.lab.example`; `10.10.10.10` | AD DS, DNS, LDAPS |
| Enterprise CA | `CA01.lab.example`; `10.10.10.11` | Internal certificate issuance and trust |
| AD domain | `lab.example` | Central identity namespace |
| SSL VPN pool | `10.50.0.0/24` | Remote client addresses |
| SSL VPN transport | TCP `8443` | Sophos Connect SSL VPN tunnel |
| VPN portal | HTTPS `443` on the public firewall address | User profile/client download |

## Access model

| Persona | AD role group | VPN authorization group | Sophos VPN policy |
| --- | --- | --- | --- |
| Student | `CG-Students` | `CG-VPN-Students` | `CloudGenius-Students-Restricted` |
| Instructor | `CG-Instructors` | `CG-VPN-Instructors` | `CloudGenius-Instructors` |
| Privileged administrator | `CG-Lab-Admins` | `CG-VPN-Admins` when specifically approved | Dedicated restricted admin policy recommended |

> Privileged administration accounts must not be used for routine VPN access. Administrators should maintain separate standard and privileged identities.

## Important distinction

This deployment uses **AD username/password authentication over secure LDAPS**. The **Single sign-on (SSO)** button in Sophos Connect refers to a separately configured identity-provider flow such as Microsoft Entra ID SSO. It is not enabled merely by adding on-premises AD/LDAPS.

## Security statement

No passwords, private keys, pre-shared keys, exported secret material, live public addresses, real usernames, certificate thumbprints, or production DNS names are stored in this repository. Scripts request sensitive values interactively.

All addresses and names in this public repository are examples or RFC 5737 documentation values. Adapt them to an authorized lab environment.
