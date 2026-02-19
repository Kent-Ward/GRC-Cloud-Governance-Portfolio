# 05-verify-after.ps1
# Verifies the group is scoped to the RG (after cleanup).

param(
  [Parameter(Mandatory=$true)]
  [string]$GroupName,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName
)

$subId = az account show --query id -o tsv
$groupId = az ad group show --group $GroupName --query id -o tsv

"Assignments (all scopes):"
az role assignment list --assignee-object-id $groupId -o table

"`nAssignments (RG scope only):"
az role assignment list `
  --assignee-object-id $groupId `
  --scope "/subscriptions/$subId/resourceGroups/$ResourceGroupName" `
  -o table
