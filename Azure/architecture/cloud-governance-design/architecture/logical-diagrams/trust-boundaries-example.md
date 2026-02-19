# Trust Boundaries — Sample Documentation

Purpose:
Document logical security boundaries between systems and access tiers.

Boundary 1: Public Internet
- Untrusted zone
- All access requires identity verification
- MFA mandatory

Boundary 2: Identity Provider (Primary Control Plane)
- Authoritative authentication source
- Conditional access enforcement
- Logs all authentication attempts

Boundary 3: SaaS Applications
- Federated authentication only
- No local credential storage
- Access governed by group membership

Boundary 4: Administrative Control Plane
- Restricted to privileged accounts
- Separate admin roles
- Logging mandatory
- No shared credentials

Boundary 5: Endpoint Devices
- Enrolled in MDM
- Disk encryption required
- Device compliance required for access

Assumptions:
- Identity is the primary perimeter
- Network is not trusted by default
- Logging is mandatory for privilege actions