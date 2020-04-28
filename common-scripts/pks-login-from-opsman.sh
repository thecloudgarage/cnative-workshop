#!/bin/bash

export uaaToken=$( sudo curl -s -k -H 'Accept: application/json;charset=utf-8' -d 'grant_type=password' -d 'username=admin' -d 'password=admin' \
  -u 'opsman:' https://localhost/uaa/oauth/token |  jq --raw-output '.access_token' )

export pksguid=$( curl "https://localhost/api/v0/staged/products" -k \
  -X GET \
  -H 'Authorization: Bearer '"$uaaToken"'' \
  | jq --raw-output '.[] | select(.installation_name|test("pivotal-container-service.")) | .guid' )

export uaaadminpassword=$( sudo curl \
  "https://opsman.thecloudgarage.com/api/v0/deployed/products/'$pksguid'/credentials/.properties.uaa_admin_password" \
  -k -H 'Authorization: bearer '"$uaaToken"'' )
  
pks login -a api.pks.aws.thecloudgarage.com -u admin -p "$uaaadminpassword" -k
