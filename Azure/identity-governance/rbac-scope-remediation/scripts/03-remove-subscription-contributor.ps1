# 03-remove-subscription-contributor.ps1
# Removes Contributor assignment at subscription scope for the group.

param(
  [Parameter(Mandatory=$true)]
  [string]$GroupName
)

$subId = az account show --query id -o tsv
$groupId = az ad group show --group $GroupName --query id -o tsv

az role assignment delete `
  --assignee-object-id $groupId `
  --role "Contributor" `
  --scope "/subscriptions/$subId"

"Deleted subscription-scope Contributor (if it existed). Verifying..."
az role assignment list --assignee-object-id $groupId -o table