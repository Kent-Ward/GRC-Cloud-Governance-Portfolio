# 04-assign-rg-contributor.ps1
# Assigns Contributor at resource group scope for the lab group.

param(
  [Parameter(Mandatory=$true)]
  [string]$GroupName,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName
)

$subId = az account show --query id -o tsv
$groupId = az ad group show --group $GroupName --query id -o tsv

az role assignment create `
  --assignee-object-id $groupId `
  --assignee-principal-type Group `
  --role "Contributor" `
  --scope "/subscriptions/$subId/resourceGroups/$ResourceGroupName"

"Assigned RG-scope Contributor. Verifying..."
az role assignment list --assignee-object-id $groupId -o table
