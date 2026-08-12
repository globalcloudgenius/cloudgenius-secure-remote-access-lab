# Learner onboarding and offboarding

## Administrator onboarding

1. Confirm the learner's approved role and course entitlement.
2. Create a standard directory identity in the appropriate organizational unit.
3. Require a domain-compliant temporary password and password change at first sign-in.
4. Add the learner to the role group and its corresponding VPN authorization group.
5. Never grant privileged administrative membership for ordinary coursework.
6. Verify that the account is enabled and only expected group memberships are present.
7. Provide the approved VPN portal address through a private channel.

The parameterized user-creation script performs the repeatable directory portion of this process.

## Learner connection process

1. Sign in to the approved VPN portal with the standard directory account.
2. Download a newly generated SSL VPN profile compatible with the approved client.
3. Remove or rename obsolete profiles for the same lab gateway.
4. Import the new profile.
5. Use the normal username-and-password method unless a separate federated SSO service has been configured.
6. Connect and test only assigned lab resources.
7. Report failures without sharing passwords, profiles, public addresses, or screenshots containing secrets.

## Administrator verification

Verify, using private logs, that:

- the expected external directory handled authentication;
- the expected authorization group and VPN policy were selected;
- the client received an address from the approved VPN pool;
- the learner can reach required resources and cannot reach prohibited resources.

## Offboarding

1. Remove remote-access group membership when training access ends.
2. Disable the account when the learner leaves the program.
3. Revoke active sessions.
4. Review recent authentication activity.
5. Remove obsolete duplicate identities after validating that they are no longer dependencies.

## Troubleshooting order

1. Account status and lockout
2. Role and VPN group membership
3. External-directory connection health
4. DNS and certificate trust
5. Fresh client profile
6. Authentication-source logs
7. VPN policy membership
8. Permitted destinations and services
9. Inter-zone firewall policy

