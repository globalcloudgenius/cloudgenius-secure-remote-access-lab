# Security hardening checklist

This checklist is intentionally environment-neutral. Track actual gaps, addresses, identities, rules, and remediation evidence in a private system of record.

## Identity

- Require MFA for remote access.
- Separate standard and privileged identities.
- Use a least-privileged directory bind account.
- Remove temporary privileged-group membership immediately after use.
- Review remote-access groups periodically.
- Disable inactive and departed-user accounts promptly.

## Certificates and secrets

- Validate server certificates; do not disable trust checks as a workaround.
- Protect CA and server private keys from export.
- Back up CA material using encrypted, access-controlled offline storage.
- Monitor certificate expiration with advance alerts.
- Rotate service-account credentials through a documented process.
- Never commit credentials, PSKs, VPN profiles, private keys, or PFX files.

## Network access

- Deny by default between security zones.
- Permit exact sources, destinations, and services.
- Keep learner, instructor, and administrator policies separate.
- Avoid broad network objects after initial validation.
- Do not expose directory services directly to the internet.
- Restrict management interfaces to approved administrative paths.

## Operations

- Back up firewall configuration after validated changes.
- Centralize time synchronization.
- Retain authentication and VPN logs according to policy.
- Test account lifecycle, certificate renewal, backup restoration, and emergency access.
- Maintain at least two directory/DNS servers for a production design.
- Perform documented access and rule reviews.

## Public repository hygiene

- Use documentation-only IP ranges and example domains.
- Redact screenshots and logs before publishing.
- Keep real topology and operational runbooks private.
- Enable repository secret scanning where available.
- Rotate any durable value accidentally exposed in a commit or screen share.

