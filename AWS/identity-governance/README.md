# AWS IAM Hardening

## Executive Summary

This project demonstrates foundational **identity governance and IAM hardening** in AWS. The objective is to reduce excessive privilege by applying least-privileged permissions, enforcing MFA, validating role-based access controls, and capturing compliance-oriented evidence using Prowler.

---

## Governance Problem

Cloud environments commonly accumulate **over-privileged identities** (e.g., users with AdministratorAccess) created for speed and never re-scoped. This increases blast radius and raises insider risk exposure.

**Risk Theme:** Identity & Access Governance (Excessive privileges / weak authentication controls)

---

## Objectives

- Create over-privileged vs least-privileged IAM users for comparison
- Apply a least-privilege policy scoped to a specific S3 bucket
- Enforce and validate MFA for IAM users
- Implement role-based access control (RBAC-style) via assume-role + trust policy
- Run a compliance scan using Prowler and capture evidence

---

## Environment & Scope

- Cloud Platform: AWS
- Services: IAM, S3
- Access Pattern: User permissions + role assumption (trust policy)
- Evidence Type: CLI output + Prowler results (redacted)

---

## Remediation Outcome

- **Before:** Over-privileged user (AdministratorAccess) represents common misconfiguration patterns
- **After:** Least-privileged user permissions scoped to a single resource boundary + MFA enabled
- **Result:** Reduced privilege scope, improved authentication posture, and evidence captured for audit readiness

---

## Validation Approach

Validation included:
- Verifying effective permissions through targeted IAM policy attachment
- Confirming MFA device association via AWS CLI
- Confirming role creation and assume-role configuration
- Running a Prowler scan and capturing findings output (redacted)

---

## Repository Structure

```
iam-hardening/
├── demo-policies/
│   ├── allowassumerole.json
│   ├── S3BucketReadOnly-demo.json
│   └── trust-policy-demo.json
├── evidence/
│   └── prowler_success.png
├── scripts/
│   └── enable-mfa-iamuser.sh  
└── README.md
```

---

## Implementation Details (CLI)

<details>
<summary>Click to expand step-by-step commands</summary>

### 1. Create IAM Users

- Over-privileged user: attached `AdministratorAccess`
- Least-privileged user: no policies initially

```bash
aws iam create-user --user-name stan_overpriv
aws iam create-user --user-name chris_leastpriv
```

---

### 2. Attach Least-Privilege Policy

A custom policy was written to allow only:
- `s3:ListBucket`
- `s3:GetObject`

Scoped to a single bucket.

**Sample Policy:** `demo-policies/S3BucketReadOnly-demo.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "BucketList",
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": "arn:aws:s3:::example-bucket"
    },
    {
      "Sid": "ObjectRead",
      "Effect": "Allow",
      "Action": ["s3:GetObject"],
      "Resource": "arn:aws:s3:::example-bucket/*"
    }
  ]
}
```

Attach the policy:

```bash
aws iam create-policy \
  --policy-name S3BucketReadOnly \
  --policy-document file://demo-policies/S3BucketReadOnly-demo.json

aws iam attach-user-policy \
  --user-name chris_leastpriv \
  --policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/S3BucketReadOnly
```

---

### 3. Enable and Validate MFA

MFA was enabled and validated for the least-privileged user.

**Check MFA devices:**

```bash
aws iam list-mfa-devices --user-name chris_leastpriv
```

Expected: a device entry is returned for the user.

> Note: Identifiers and device serials are redacted for public sharing.

---

### 4. Create IAM Role and Configure Trust Policy

A role was created with limited permissions and a trust policy allowing only the intended principal to assume it.

```bash
aws iam create-role \
  --role-name S3ReadOnlyRole \
  --assume-role-policy-document file://demo-policies/trust-policy-demo.json

aws iam put-role-policy \
  --role-name S3ReadOnlyRole \
  --policy-name S3BucketReadOnlyInline \
  --policy-document file://demo-policies/allowassumerole.json
```

---

### 5. Run Prowler Compliance Scan (CIS-oriented)

Prowler was executed in WSL (Ubuntu) due to dependency issues on Windows.

```bash
python3 prowler-cli.py aws -M html,json,csv -o output/ --output-filename prowler_report
```

Evidence captured:
- `evidence/prowler_success.png`

</details>

---

## Key Takeaways

- Least privilege must be enforced through **scoped policies**, not broad managed roles.
- MFA is a baseline identity governance requirement for interactive accounts.
- Role assumption with trust policies supports stronger access boundaries and reduces static privilege.
- Compliance tooling (Prowler) helps validate control posture and produce audit-aligned evidence.

---

Author: Kent Ward  
Focus Area: Identity & Access Governance (AWS IAM)  

