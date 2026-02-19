# Information Classification & Protection (Microsoft Purview)

## Overview

This project demonstrates the design and implementation of an information classification and protection model using Microsoft Purview Sensitivity Labels in a small-to-medium business (SMB) environment.

The focus of this work is governance-first design — prioritizing clarity, risk reduction, and operational maturity over rushed enforcement.

Rather than enabling every available control, this implementation intentionally sequences protections based on organizational size, risk surface, and adoption readiness.

---

## Objectives

- Design a clear, scalable data classification model  
- Implement encryption-backed protection for sensitive information  
- Establish a defensible label hierarchy and priority model  
- Publish labels in a way that supports adoption before enforcement  
- Align technical controls to common compliance frameworks (SOC 2, ISO 27001, NIST)

---

## Classification Model

The following sensitivity labels were designed and implemented:

| Label        | Purpose                                           | Enforcement Level                     |
|--------------|---------------------------------------------------|---------------------------------------|
| Public       | Information approved for public distribution      | Classification only                   |
| Internal     | Internal business information                     | Visual marking (footer)               |
| Confidential | Sensitive business or client information          | Encryption + access control            |
| Restricted  | Highly sensitive security or credential data      | Strong encryption + restricted access |

### Label Priority (Highest → Lowest)

1. Restricted  
2. Confidential  
3. Internal  
4. Public  

This ensures the most restrictive label always takes precedence in conflict scenarios.

---

## Scope of Implementation

### In Scope

- Sensitivity label creation  
- Label priority configuration  
- Encryption via Microsoft Rights Management (RMS)  
- File and email protection  
- Label publishing policy design  
- User-facing rollout (email and documents)  

### Out of Scope (Intentional)

- Auto-labeling  
- Mandatory labeling  
- Default labels for files or email  
- Teams / SharePoint container labeling  
- Client or production data  

These controls were intentionally deferred to later maturity phases.

---

## Design Decisions & Rationale

### Why No Auto-Labeling?

Auto-labeling was intentionally excluded to:

- Ensure accuracy through manual intent  
- Avoid false positives in a small environment  
- Establish labeling discipline before automation  

### Why No Default Labels?

Default labeling introduces enforcement behavior.  
This implementation favors adoption-first rollout, allowing users to apply labels intentionally before stricter controls are introduced.

### Why Encryption Only for Confidential & Restricted?

Encryption is applied where risk justifies friction:

- Confidential and Restricted data require enforced protection  
- Public and Internal data benefit more from clarity than restriction  

---

## Security Controls Implemented

- Microsoft Rights Management Service (RMS) activation  
- Encryption-based access control for sensitive data  
- Restricted forwarding for high-sensitivity email  
- Visual classification markings for awareness  
- Single, centralized label publishing policy  

---

## Framework Alignment

This implementation supports the following control families:

### ISO/IEC 27001
- A.5 – Information security policies  
- A.8 – Information classification and handling  

### SOC 2
- CC6 – Logical and physical access controls  
- CC7 – System operations and change management  

### NIST CSF
- PR.DS – Data Security  
- PR.AC – Access Control  

---

## Evidence & Artifacts

This repository contains:

- Redacted screenshots (where appropriate)  
- Additional policy and risk templates may be added as separate, standalone artifacts.
 

All tenant-specific identifiers, domains, and data have been intentionally excluded.

---

## Key Takeaway

Effective information protection is not about enabling every feature — it’s about applying the right controls at the right time.

This project reflects a practical, audit-defensible approach to information classification that can scale as organizational maturity increases.

---

## Disclaimer

This repository is for demonstration and educational purposes only.  
No proprietary, client, or production data is included.

---

## Author

**Kent Ward**  
GRC Engineer
