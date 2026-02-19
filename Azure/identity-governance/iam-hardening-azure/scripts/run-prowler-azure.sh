#!/bin/bash

# Ensure you've already exported the following in your terminal:
# AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID

sudo docker run --rm -it \
  -v "$(pwd)/output:/output" \
  -e AZURE_CLIENT_ID=$AZURE_CLIENT_ID \
  -e AZURE_CLIENT_SECRET=$AZURE_CLIENT_SECRET \
  -e AZURE_TENANT_ID=$AZURE_TENANT_ID \
  -e AZURE_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID \
  toniblyx/prowler:latest \
  azure \
  --subscription-id $AZURE_SUBSCRIPTION_ID \
  --sp-env-auth \
  --compliance cis_3.0_azure \
  -M csv \
  -o /output
