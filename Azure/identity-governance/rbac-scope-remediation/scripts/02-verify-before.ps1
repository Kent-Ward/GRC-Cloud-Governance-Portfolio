# 02-verify-before.ps1
# Verifies current role assignments for the lab group (before cleanup).

param(
  [Parameter(Mandatory=$true)]
  [string]$GroupName
)

$subId = az account show --query id -o tsv
$groupId = az ad group show --group $GroupName --query id -o tsv

"SubscriptionId: $subId"
"GroupObjectId:  $groupId"
"Assignments:"
az role assignment list --assignee-object-id $groupId -o table