#!/bin/bash

export uaaToken=$( sudo curl -s -k -H 'Accept: application/json;charset=utf-8' -d 'grant_type=password' -d 'username=admin' -d 'password=admin' \
  -u 'opsman:' https://localhost/uaa/oauth/token |  jq --raw-output '.access_token' )

export uaaadminpassword=$( sudo curl \
  "https://opsman.thecloudgarage.com/api/v0/deployed/director/credentials/uaa_admin_user_credentials" \
  -k -H 'Authorization: bearer '"$uaaToken"'' | jq --raw-output '.credential.value.password' )

echo "bosh passowrd is $uaaadminpassword"

bosh alias-env aws-pcf -e 10.0.1.11 --ca-cert /var/tempest/workspaces/default/root_ca_certificate

bosh -e aws-pcf login
