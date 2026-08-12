# Security policy

This repository contains configuration guidance and administrative scripts. It must never contain production credentials or private cryptographic material.

If a password, private key, pre-shared key, VPN profile, session token, or recovery code is committed:

1. Revoke or rotate the exposed value immediately.
2. Remove it from the current tree and Git history.
3. Review authentication and administrative logs.
4. Document the incident and corrective action.

Report security issues privately to the CloudGenius system owner rather than opening a public issue containing sensitive details.

The hostnames, IP addresses, domains, and identities in this repository are documentation examples. Do not replace them with live infrastructure details in public commits.
