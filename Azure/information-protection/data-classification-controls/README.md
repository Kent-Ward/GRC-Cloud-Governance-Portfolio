# Information Classification & Protection

(Microsoft Purview - Sensitivity Labels & Data Governance)

---

## Executive Summary

This project demonstrates the design and implementation of a structured **information classification and protection model** using Microsoft Purview Sensitivity Labels in a small-to-medium business (SMB) environment.

The objective was to reduce data exposure risk by introducing a defensible classification hierarchy, encryption-backed protection for sensitive information, and a phased adoption strategy aligned to governance maturity principles.

---

## Governance Problem

Organizations frequently struggle with:

- Inconsistent classification of sensitive data

- Overuse or underuse of encryption controls

- Lack of formalized data handling policies

- Enforcement mechanisms deployed before user adoption

Without a structured classification model, sensitive information is exposed to accidental sharing, regulatory risk, and uncontrolled distribution.

**Risk Theme:** Data Governance & Information Protection (Improper classification + uncontrolled data exposure)

---

## Objectives

- Design a scalable classification taxonomy

- Implement encryption-backed protection for high-risk data

- Establish a clear label priority model

- Deploy labels in an adoption-first sequence

- Align technical implementation to recognized compliance frameworks

---

## Environment & Scope

- Platform: Microsoft Purview (M365 / Entra ecosystem)

- Protection Technology: Microsoft Rights Management (RMS)

- Deployment Model: Manual labeling with staged governance maturity

- Organizational Context: SMB environment with controlled rollout

---

## Repository Structure

```
data-classification-controls/
├── policies/
├── risk/
├── screenshots/
└── README.md
```
---

## Classification Model Implemented

| Label        | Purpose                                           | Enforcement Level                        |
|--------------|---------------------------------------------------|------------------------------------------|
| Public       | Approved for public distribution                  | Classification only                      |
| Internal     | Internal business information                     | Visual marking (footer)                  |
| Confidential | Sensitive business or client information          | Encryption + access control              |
| Restricted   | Highly sensitive security or credential data      | Strong encryption + restricted forwarding |

### Label Priority (Highest -> Lowest)

1. Restricted  
2. Confidential  
3. Internal  
4. Public  

This ensures the most restrictive label prevails in conflict scenarios.

---

## Remediation Outcome

**Before**

- No standardized classification hierarchy

- Inconsistent protection of sensitive data

- No enforced encryption for high-risk content

- Limited audit defensibility

**After**

- Structured label taxonomy implemented

- Encryption enforced for high-risk data tiers

- Clear label priority governance model

- Centralized publishing policy

- Scalable foundation for future maturity (auto-labeling, DLP)

**Result:** Reduced accidental exposure risk and improved compliance defensibility.

---

## Security Controls Implemented

- Activation of Microsoft Rights Management Service (RMS)

- Encryption-based access control for Confidential & Restricted labels

- Restricted email forwarding for high-sensitivity content

- Visual classification markings for user awareness

- Centralized sensitivity label publishing policy

---

## Validation & Evidence

- Confirmed label publication across target user scope

- Verified encryption enforcement on labeled documents

- Tested access restrictions for restricted recipients

- Validated footer markings and visual indicators

- Confirmed restricted forwarding enforcement in Outlook

**See screenshots folder**
- All tenant-specific identifiers and production data were intentionally excluded.

---

## Design Decision & Governance Rationale

### Adoption-First Strategy

**Auto-labeling and manadatory labeling were intenitonally deferred to:**

- Avoild false positives
- Promote user education
- Reduce operational friction
- Establish labeling discipline

### Encryption Scope Decisions 

**Encryption applied onky where risk justifies friction:**

- Confidential and Restricted -> Enforced protection
- Internal and Public -> Awareness-focused classification

---

---

## Controls & Framework Alignment

### NIST Cybersecurity Framework (CSF 2.0)

| Function | Category | Implementation Alignment |
|----------|----------|--------------------------|
| PR.DS | Data Security | Encryption applied to sensitive information tiers |
| PR.AC | Access Control | RMS-based access restriction and forwarding limits |
| GV.RM | Risk Management | Tiered data classification reduces exposure risk |
| DE.CM | Continuous Monitoring | Label usage visibility through Purview dashboard |

---

### ISO/IEC 27001:2022

| Control | Control Name | Implementation |
|---------|-------------|---------------|
| A.5.12 | Classification of Information | Defined multi-tier classification model |
| A.5.15 | Access Control | Encryption and access restriction for high-risk data |
| A.5.17 | Authentication Information | Identity-based enforcement of protected content |
| A.8.12 | Data Leakage Prevention | Restricted forwarding and encryption enforcement |

---

### SOC 2 (Trust Services Criteria)

| Control Family | Alignment |
|---------------|-----------|
| CC6 | Logical access controls for sensitive data |
| CC7 | Monitoring and change governance for label configuration |

---

## Key Takeaways

- Information protection must align with organizational maturity.

- Over-enforcement early can reduce adoption and increase resistance.

- Encryption should be risk-justified, not universally applied.

- Governance-first design creates audit defensibility.

- Data classification is foundational to broader compliance programs.

---

Author: Kent Ward  
Cloud Governance, Risk & Identity Engineering
Azure | Purview | IAM | Compliance | Risk Reduction

