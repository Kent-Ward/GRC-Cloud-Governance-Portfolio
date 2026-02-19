#!/bin/bash

# Lists Azure AD users and their MFA status
az ad user list \
  --query "[].{Name: displayName, MFA: strongAuthenticationMethods}" \
  --output table
