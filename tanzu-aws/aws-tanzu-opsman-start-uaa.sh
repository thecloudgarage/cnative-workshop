#!/bin/bash
curl -k "https://tanzu-opsman.aws.thecloudgarage.com/api/v0/setup" \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{ "setup": {
  "decryption_passphrase": "admin",
  "decryption_passphrase_confirmation":"admin",
  "eula_accepted": "true",
  "identity_provider": "internal",
  "admin_user_name": "admin",
  "admin_password": "admin",
  "admin_password_confirmation": "admin"
} }'
