# Current vs Planned Architecture Model

Purpose:
Provide clarity for executive visibility and audit tracking.

---

## Current State

IAM:
- Group-based access partially implemented
- MFA enabled for privileged users only
- Break glass documentation and tested 

Logging:
- Logs enabled and centralized
- Retention less than 30 days
- No alerting for privilege changes

Device:
- Encryption inconsistent
- Enforced MDM compliance

Risk Level:
Medium to High

---

## Planned State (6-12 Month Roadmap)

IAM:
- MFA enforced for all users
- Zero shared admin accounts
- Role-based access model finalized

Logging:
- Centralized logging workspace
- 180+ day retention
- Alerting for:
  - Privilege escalation
  - Conditional policy changes
  - Suspicious login patterns

Device:
- Disk encryption enforced
- Conditional access device compliance required

Target Risk Level:
Low to Medium (Controlled)

---

Executive Value:
- Reduced audit findings
- Reduced insider risk
- Improved visibility into security events