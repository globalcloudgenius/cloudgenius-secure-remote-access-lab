# Learning outcomes and practical exercises

## Technical learning outcomes

After completing this lab, a learner should be able to:

1. Explain the difference between authentication, authorization, SSO, MFA, LDAP, and LDAPS.
2. Design AD organizational units and security groups around roles rather than individual firewall accounts.
3. Install and configure an Enterprise Certification Authority in an authorized lab.
4. Create and publish a certificate template suitable for domain-controller authentication.
5. Verify certificate subject, SAN, trust chain, validity, private-key presence, and server-authentication EKU.
6. Validate DNS resolution and TCP 636 connectivity before troubleshooting credentials.
7. Configure Sophos to validate the LDAPS server certificate.
8. Import AD authorization groups and map them to separate SSL VPN policies.
9. Explain split tunneling and apply least-privilege network-resource selection.
10. Use Sophos authentication logs to distinguish local authentication from external AD authentication.
11. Onboard and offboard users through repeatable PowerShell and AD group membership.
12. Document business value, security controls, evidence, risks, and follow-up actions.

## Director and architecture learning outcomes

A leader should be able to connect the implementation to organizational outcomes:

- Centralized lifecycle management reduces duplicated administration.
- Role-based access supports segregation of duties and repeatable governance.
- Certificate validation reduces credential interception risk.
- Separate standard and privileged identities reduce administrative exposure.
- Logs and validation evidence improve auditability.
- Parameterized automation reduces configuration drift.
- A prioritized hardening backlog turns a successful proof of concept into an operational service.

## Suggested student exercises

### Exercise 1 — Identity structure

Run `01-Initialize-CloudGeniusStructure.ps1` with an authorized lab domain DN. Verify that rerunning it does not duplicate OUs or groups.

### Exercise 2 — Role-based onboarding

Use `02-New-CloudGeniusUser.ps1` to create one student and one instructor. Confirm each receives only the expected role and VPN groups.

### Exercise 3 — Certificate validation

On the domain controller, inspect the LDAPS certificate and record:

- subject and SAN;
- issuer;
- expiration;
- server-authentication EKU;
- private-key availability.

Do not export the private key.

### Exercise 4 — Network validation

Use `04-Verify-CloudGeniusAccess.ps1` to test group presence, DNS, TCP 636, and the local certificate store. Explain why a successful port test alone does not prove certificate trust or valid credentials.

### Exercise 5 — Policy comparison

Compare the student and instructor VPN policies. Replace a broad network object with exact lab destinations and services, then document the reduced exposure.

### Exercise 6 — Evidence-based troubleshooting

Generate a controlled failed login, then a successful login. Use the Sophos authentication log to identify the authentication source, reason, group, and assigned policy. Redact usernames and addresses before sharing evidence.

## Completion evidence

- Script verification output with secrets and identities redacted
- Screenshot or exported record of the published certificate template
- Sanitized certificate metadata
- Sophos AD connectivity success
- Sanitized authentication log showing external-directory success
- Student/instructor policy comparison
- One-page reflection connecting the technical controls to business value

