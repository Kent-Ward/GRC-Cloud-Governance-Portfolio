# Azure RBAC Scope Remediation 
*(Subscription vs Resource Group – Governance Case Study)*

---

## Executive Summary

This project demonstrates identification and remediation of **over-scoped Azure RBAC access** by moving a role assignment from **subscription scope** to the minimum required **resource group scope**.

The objective was governance-driven:

- Reduce blast radius
- Enforce least privilege
- Validate effective access
- Document defensible remediation steps

This simulates a real-world identity governance scenario involving excessive privilege at the subscription level.

---

## Governance Problem

A security group was granted **Contributor** at the **subscription scope** to accelerate deployments.

While operationally convenient, this created:

- Broad access across all resource groups
- Access to current and future resources
- Increased attack surface
- Elevated insider risk

Without scope restriction, privilege persistence becomes difficult to audit and control.

**Risk Theme:** Identity & Access Governance (Over-privileged access)

---

## Objectives

- Identify over-scoped access at subscription scope
- Validate RBAC scope hierarchy and inheritance behavior
- Remove excessive privilege at the subscription level
- Reassign access at the **resource group scope only**
- Verify reduced blast radius through CLI validation

---

## Environment & Scope

- Cloud Platform: Microsoft Azure
- Identity Provider: Microsoft Entra ID
- Principal Type: Security Group
- Roles Demonstrated: Contributor

### Scopes Demonstrated:
  - Subscription (over-scoped)
  - Resource Group (least privilege target)

---

## Key Concepts Demonstrated

### Scope Determines Blast Radius
Azure RBAC scope defines how far permissions apply:
- **Subscription** impacts everything in the subscription
- **Resource Group** impacts only resources in that RG
- **Resource** impacts only that resource

### RBAC Inheritance Is Hierarchical
Role assignments at higher scopes automatically flow down to lower scopes. Azure does **not** duplicate assignments at child scopes—access appears as inherited when viewed at lower levels.

### Over-Scoped Roles Increase Risk
Granting Contributor (or Owner) at subscription scope:
- Expands attack surface
- Increases insider risk potential
- Violates least privilege principles
- Complicates audit review

---

## Remediation Outcome

### Before

- Contributor assigned at subscription scope
- Broad access across entire environment
- Privilege persistence

### After

- Subscription-level assignment removed
- Contributor assigned only at resource group scope
- Reduced blast radius
- Controlled privilege boundary

**Result:** Access aligned to operational requirement without unnecessary exposure.

---

## Validation Approach

Validation was performed using Azure CLI to confirm:
- Role assignment exists at the correct scope
- Over-scoped assignment is removed
- Effective access is limited to the resource group scope

---

## Implementation Details (CLI)

<details>
<summary>Click to expand step-by-step commands</summary>

### Prerequisites

- Azure subscription available for safe testing
- Your account has **Owner** or **User Access Administrator** at subscription scope
- Azure CLI installed
- PowerShell (Windows Terminal) or VS Code terminal
- Microsoft Entra ID security group:
  - `sg-rbac-lab-contributors`

### Reference Resources (Example)

- Subscription (optional name): `TS-RBAC-LAB-SUBS`
- Resource Group: `rg-rbac-lab-001`
- Storage Account (example): `strbaclab001kw01`

---

### Phase 1 - Create Scope (Portal)

1. Create resource group: `rg-rbac-lab-001`
2. Create a storage account inside the RG (any unique name)
3. Create Entra security group: `sg-rbac-lab-contributors`
   - Keep: “Microsoft Entra roles can be assigned to the group” = **No**
   - Add yourself as a member (temporary for lab/testing)

---

### Phase 2 - Create Over-Scoped Condition (CLI)

#### 1. Login and set subscription

```powershell
az login
az account set --subscription "TS-RBAC-LAB-SUBS"
```

#### 2. Capture required IDs

```powershell
$subId = az account show --query id -o tsv
$groupId = az ad group show --group "sg-rbac-lab-contributors" --query id -o tsv
```

#### 3. Assign Contributor at subscription scope (intentionally over-scoped)

```powershell
az role assignment create `
  --assignee-object-id $groupId `
  --assignee-principal-type Group `
  --role "Contributor" `
  --scope "/subscriptions/$subId"
```

#### 4. Verify assignment

```powershell
az role assignment list --assignee-object-id $groupId -o table
```

---

### Phase 3 — Remediate to Least Privilege

#### 1. Remove subscription-level Contributor

```powershell
az role assignment delete `
  --assignee-object-id $groupId `
  --role "Contributor" `
  --scope "/subscriptions/$subId"
```

#### 2. Verify removal

```powershell
az role assignment list --assignee-object-id $groupId -o table
```

#### 3. Reassign Contributor at RG scope only

```powershell
az role assignment create `
  --assignee-object-id $groupId `
  --assignee-principal-type Group `
  --role "Contributor" `
  --scope "/subscriptions/$subId/resourceGroups/rg-rbac-lab-001"
```

#### 4. Verify corrected scope

```powershell
az role assignment list --assignee-object-id $groupId -o table
```

</details>

---

## Controls & Framework Alignment

This remediation aligns with several recognized governance and security frameworks by enforcing least-privilege access and reducing excessive role scope within Azure RBAC.

### NIST Cybersecurity Framework (CSF 2.0)

| Function | Category | Implementation Alignment |
|----------|----------|--------------------------|
| PR.AC | Access Control | Scoped role assignment to minimum required boundary |
| PR.AA | Identity Management & Authentication | Group-based RBAC used instead of individual user permissions |
| GV.RM | Risk Management Strategy | Reduction of excessive privilege exposure |
| DE.CM | Continuous Monitoring | Azure CLI validation of effective role assignment |

---

### ISO/IEC 27001:2022

| Control | Control Name | Implementation |
|---------|-------------|---------------|
| A.5.15 | Access Control | RBAC assignments restricted to least required scope |
| A.5.18 | Access Rights | Removal of unnecessary subscription-level privileges |
| A.8.15 | Logging & Monitoring | CLI-based verification of effective role scope |

---

### CIS Controls v8

| Control | Safeguard | Implementation |
|----------|----------|---------------|
| 5 | Account Management | Security group-based access control |
| 6 | Access Control Management | Removal of over-scoped role assignments |
| 8 | Audit Log Management | Validation of effective role assignments |

---

### CIS Microsoft Azure Foundations Benchmark

Relevant control areas addressed include:

- Identity and Access Management
- Role-Based Access Control governance
- Least privilege enforcement
- Permission scope restriction


## Key Takeaways

- **Subscription scope equals maximum blast radius.** Use it sparingly and intentionally.
- **Inheritance can mask over-scoping.** Always confirm effective access at the correct scope.
- **Group-based RBAC is best practice**, but must be paired with correct scoping.
- **Least privilege is a governance lifecycle:** assign → validate → review → remediate.

---

## Suggested Future Enhancements

- Add a periodic access review process (quarterly RBAC review)
- Integrate Azure Activity Logs into a centralized logging destination
- Implement Privileged Identity Management (PIM) for just-in-time elevation
- Add a lightweight control mapping appendix (NIST/CIS)

---

Author: Kent Ward  
Focus Area: Identity & Access Governance (Azure RBAC)
