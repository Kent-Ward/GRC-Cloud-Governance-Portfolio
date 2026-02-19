# 01-set-context.ps1
# Sets subscription context and prints current account.

param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionName
)

az login | Out-Null
az account set --subscription $SubscriptionName
az account show -o table