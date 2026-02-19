# 🔐 Conditional Access Policy - Summary

**Policy Name**: Require MFA for All Users  
**Status**: ✅ Enabled (Enforced, not in Report-only mode)  
**Scope**:
- **Users**: All users included (except excluded if configured)
- **Target Resources**: All resources (formerly "All cloud apps")
- **Network**: Not configured
- **Conditions**: None selected
- **Access Controls - Grant**: Require Multi-Factor Authentication
- **Session Controls**: None selected

📸 **Screenshot evidence saved in:**  
`/azure/evidence/ca-policy-screenshot.png`

---

## 📌 Notes

- Created via Azure Portal (GUI), not via CLI or PowerShell  
- Enforces baseline identity protection across the tenant  
- MFA will be triggered for all sign-ins regardless of location, app, or device  
- This control was enabled **after** Privileged Identity Management (PIM) was configured and tested

---

> 🔒 This is a redacted demonstration of Conditional Access used as part of an IAM Hardening Lab. No identifying information has been included.

