# Evidence Checklist (RBAC Cleanup Lab)

Add screenshots here to prove each step.

## Before State
- 01 - Subscription IAM shows `sg-rbac-lab-contributors` has **Contributor** at subscription scope
- 02 - Resource Group "Check access" shows **Subscription (Inherited)**
- 03 - Storage account "Check access" shows **Subscription (Inherited)**

## Cleanup
- 04 - CLI output showing subscription-level role assignment deleted (or empty list)
- 05 - Portal subscription IAM no longer shows the group assignment

## After State
- 06 - Resource Group IAM shows group assigned **Contributor** at RG scope ("This resource")
- 07 - Storage account "Check access" shows inherited access from RG

## Recommended File Names
- 01-subscription-before.png
- 02-rg-check-access-before.png
- 03-storage-check-access-before.png
- 04-cli-delete-verify.png
- 05-subscription-after.png
- 06-rg-after.png
- 07-storage-after.png
