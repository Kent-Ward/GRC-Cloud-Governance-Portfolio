# Azure IAM Hardening
(Identity Governance & Privileged Access Controls)

---

## Executive Summary

This project demonstrates applied identity governance hardening in Microsoft Azure. The focus is on reducing excessive privilege, enforcing multi-factor authentication (MFA), implementing just-in-time privileged access using Privileged Identity Management (PIM), and validating control posture through compliance scanning.

The objective was to simulate a real-world identity risk scenario and implement governance-aligned remediation controls.

---

## Governance Problem

Cloud environments frequently contain:

- Permanently assigned privileged roles

- Weak or inconsistent MFA enforcement

- Over-privileged identities

- Limited visibility into compliance posture

Without governance controls, administrative access becomes persistent and difficult to audit.

**Risk Theme:** Identity & Access Governance (Excessive privilege + weak authentication controls)

---

## Objectives

- Create over-privileged and least-privileged Azure identities

- Implement Microsoft Entra ID Premium P2 licensing for governance features

- Configure Privileged Identity Management (PIM) with time-bound access

- Enforce MFA through Conditional Access

- Run CIS 3.0 Azure compliance scans using Prowler

- Capture audit-aligned evidence

---

## Environment & Scope

- Cloud Platform: Microsoft Azure

- Identity Provider: Microsoft Entra ID

**Controls Implemented:**

- Role-Based Access Control (RBAC)

- Privileged Identity Management (PIM)

- Conditional Access (MFA enforcement)

- Service Principal–based compliance scanning

- Compliance Benchmark: CIS Microsoft Azure Foundations Benchmark v3.0

---

## Repository Structure

```
iam-hardening-azure/
├── demo-policies/
│   └── conditional-access-summary.md
├── evidence/
│   ├── AzureScan_Success.jpg
│   └── ca-policy-screenshot.jpg
├── scripts/
│   ├── create-service-principal.sh
│   ├── check-mfa-status.sh
│   └── run-prowler-azure.sh
└── README.md
```

---

## Remediation Outcome

**Before**

- Over-privileged administrative user

- No time-bound role activation

- MFA posture not centrally validated

- No structured compliance visibility

**After**

- Least-privileged identity model implemented

- PIM enforcing just-in-time role activation

- MFA required for role activation

- Conditional Access policies enforced

- CIS benchmark scan executed and documented

**Result:** Reduced privilege persistence, improved authentication assurance, and evidence-backed governance validation.

---

## Implementation Details (Technical Execution)

<details>
<summary>Click to expand CLI & configuration steps</summary>

### 1. Identity Creation

Created:

- `stan_overpriv` → Administrative role (simulated risk condition)
- `chris_leastpriv` → Restricted account

Configured:
- `usageLocation`
- Entra ID Premium P2 licensing (required for PIM)
- Role visibility validation

---

### 2. Privileged Identity Management (PIM)

Configured:

- Eligible (not permanent) role assignment
- 1-hour maximum activation duration
- MFA required for activation
- Justification required (ticket ID + reason)

Validated activation flow using Owner role.

---

### 3. Conditional Access & MFA Enforcement

Sequence followed:

1. License assignment
2. PIM configuration
3. Conditional Access policy (Require MFA for all users)
4. Enable Default Security Settings (last)

---

### 4. Compliance Scanning with Prowler (CIS 3.0)

#### Create Service Principal

```bash
az ad sp create-for-rbac \
  --name prowler-sp \
  --role Reader \
  --scopes /subscriptions/<SUBSCRIPTION_ID>
``` 
---

**Export Credentials (WSL)**

```bash
export AZURE_CLIENT_ID=<CLIENT_ID>
export AZURE_CLIENT_SECRET=<CLIENT_SECRET>
export AZURE_TENANT_ID=<TENANT_ID>
export AZURE_SUBSCRIPTION_ID=<SUBSCRIPTION_ID>

```
---
**Run Prowler via Docker**

```bash
sudo docker run --rm -it \
  -v "$(pwd)/output:/output" \
  -e AZURE_CLIENT_ID=$AZURE_CLIENT_ID \
  -e AZURE_CLIENT_SECRET=$AZURE_CLIENT_SECRET \
  -e AZURE_TENANT_ID=$AZURE_TENANT_ID \
  -e AZURE_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID \
  toniblyx/prowler:latest \
  azure \
  --subscription-id $AZURE_SUBSCRIPTION_ID \
  --sp-env-auth \
  --compliance cis_3.0_azure \
  -M csv \
  -o /output
```
</details> 
    
---

## Validation & Evidence

- Confirmed eligible vs. permanent role assignments via PIM
- Tested time-bound activation (1-hour duration)
- Verified MFA enforcement during activation
- Executed CIS 3.0 compliance scan via Prowler
- Captured output in evidence/ directory

```
Compliance Status of CIS_3.0_AZURE Framework:
100% FAIL (17) | 0% PASS (0) | 0% MUTED (0)
```
- This demonstrates control visibility and the ability to measure posture gaps.

---

## Controls & Framework Alignment

This project aligns with multiple industry-recognized governance and security frameworks.

### NIST Cybersecurity Framework (CSF 2.0)

| Function | Category | Implementation Alignment |
|----------|----------|--------------------------|
| PR.AA | Identity Management & Authentication | Enforced MFA through Conditional Access |
| PR.AC | Access Control | Implemented least privilege via RBAC and PIM |
| DE.CM | Continuous Monitoring | Executed CIS compliance scan via Prowler |
| GV.RM | Risk Management Strategy | Reduced excessive privilege exposure |

---

### ISO/IEC 27001:2022

| Control | Control Name | Implementation |
|---------|-------------|---------------|
| A.5.15 | Access Control | Scoped role assignments and privilege restriction |
| A.5.17 | Authentication Information | MFA enforcement for interactive access |
| A.5.18 | Access Rights | Time-bound role activation using PIM |
| A.8.15 | Logging & Monitoring | Compliance validation via Prowler output |

---

### CIS Controls v8

| Control | Safeguard | Implementation |
|----------|----------|---------------|
| 5 | Account Management | Modeled over-privileged vs least-privileged accounts |
| 6 | Access Control Management | Enforced just-in-time administrative access |
| 8 | Audit Log Management | Captured compliance evidence for validation |
| 12 | Network & Infrastructure Monitoring | CIS Azure benchmark assessment execution |

---

### CIS Microsoft Azure Foundations Benchmark v3.0

Compliance checks aligned to:

- Identity & Access Management controls
- Logging & Monitoring configuration
- Security baseline enforcement

---

## Key Takeaways

- Permanent privileged roles increase organizational risk.

- PIM enforces least privilege through time-bound activation.

- MFA enforcement should be validated, not assumed.

- Compliance scanning provides measurable governance visibility.

- Identity governance requires both preventative and detective controls.

---

Author: Kent Ward  
Role Focus: Cloud Governance, Risk & Identity Engineering
Azure | AWS | IAM | Compliance | Risk Reduction
