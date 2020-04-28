#!/bin/bash

export uaaToken=$( sudo curl -s -k -H 'Accept: application/json;charset=utf-8' -d 'grant_type=password' -d 'username=admin' -d 'password=admin' \
  -u 'opsman:' https://localhost/uaa/oauth/token |  jq --raw-output '.access_token' )
  
| jq --raw-output '.[] | select(.installation_name|test("pivotal-container-service.")) | .guid'
