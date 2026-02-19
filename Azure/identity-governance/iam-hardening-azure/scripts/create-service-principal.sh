#!/bin/bash

# Creates a read-only service principal for Prowler scans
az ad sp create-for-rbac \
  --name prowler-sp \
  --role Reader \
  --scopes /subscriptions/<YOUR_SUBSCRIPTION_ID>

echo "Paste the returned values into your environment as:"
echo "export AZURE_CLIENT_ID=..."
echo "export AZURE_CLIENT_SECRET=..."
echo "export AZURE_TENANT_ID=..."
echo "export AZURE_SUBSCRIPTION_ID=..."
