#!/bin/bash

# Replace these with your actual values
USERNAME="demo_user"
PROFILE="lab-admin"  # or whatever AWS profile you're using

# Step 1: Create a virtual MFA device
aws iam create-virtual-mfa-device \
  --virtual-mfa-device-name "${USERNAME}-mfa" \
  --outfile "${USERNAME}-mfa-qr.png" \
  --bootstrap-method QRCodePNG \
  --profile $PROFILE

echo "✅ QR code saved as ${USERNAME}-mfa-qr.png"
echo "📲 Scan this QR code using Google Authenticator or Authy"
echo "Then enter the two consecutive MFA codes from the app..."

# Step 2: Prompt for two MFA tokens
read -p "🔐 MFA Code 1: " CODE1
read -p "🔐 MFA Code 2: " CODE2

# Step 3: Enable MFA device
aws iam enable-mfa-device \
  --user-name $USERNAME \
  --serial-number "arn:aws:iam::<ACCOUNT_ID>:mfa/${USERNAME}-mfa" \
  --authentication-code1 $CODE1 \
  --authentication-code2 $CODE2 \
  --profile $PROFILE

echo "✅ MFA device enabled for $USERNAME"
