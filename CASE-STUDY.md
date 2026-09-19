# Case Study — Secure Remote Access with AD, PKI, LDAPS and Firewall VPN

## Executive summary

This project documents a validated secure remote-access implementation integrating Active Directory identity, enterprise PKI, certificate-validated LDAPS, firewall authentication, group-based authorization, and SSL VPN.

## Business problem

Remote access becomes difficult to govern when firewall access is managed separately from enterprise identity.

The objective was to centralize authentication and authorization while keeping privileged administration separated from routine user access.

## Implemented solution

The environment integrates:

- Active Directory Domain Services;
- enterprise certificate authority;
- LDAPS;
- Sophos Firewall;
- imported AD security groups;
- role-based VPN policies;
- split-tunnel access;
- separate student, instructor, and privileged-administration concepts.

## Validated result

The end-to-end design was tested with:

- a new AD test user;
- a freshly generated Sophos Connect profile;
- successful SSL/TCP VPN establishment.

That validation confirmed the full chain of:

identity -> certificate trust -> directory lookup -> group mapping -> firewall policy -> VPN tunnel.

## Security decisions

The implementation explicitly separates routine access from privileged administration.

The public repository also avoids storing:

- passwords;
- private keys;
- pre-shared keys;
- live public addresses;
- real usernames;
- certificate thumbprints;
- production DNS names.

## Business value

This pattern is relevant when an organization needs:

- centralized access control;
- auditable remote-access policy;
- identity-backed VPN;
- PKI-backed trust;
- reduced local firewall account sprawl;
- role-based access segmentation.

## Consulting outcome

A client engagement could include:

- current-state VPN review;
- identity integration;
- PKI and LDAPS design;
- firewall policy design;
- privileged-access separation;
- user onboarding workflow;
- operational documentation;
- security hardening.

## Evidence

See:

- [Executive summary](./docs/executive-summary.md)
- [Implementation record](./docs/implementation-record.md)
- [Security hardening](./docs/security-hardening.md)

## Engagement fit

Relevant for:

- secure remote-access projects;
- firewall modernization;
- identity integration;
- PKI;
- VPN architecture;
- privileged-access hardening.

**Consulting inquiries:** advisory@cloudgenius.ca
