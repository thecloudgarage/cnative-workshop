#!/bin/sh

export uaaToken=$( sudo curl -s -k -H 'Accept: application/json;charset=utf-8' -d 'grant_type=password' -d 'username=admin' -d 'password=admin' \
  -u 'opsman:' https://localhost/uaa/oauth/token |  jq --raw-output '.access_token' )

export pksguid=$( curl "https://localhost/api/v0/staged/products" -k \
  -X GET \
  -H 'Authorization: Bearer '"$uaaToken"'' \
  | jq --raw-output '.[] | select(.installation_name|test("pivotal-container-service.")) | .guid' )

echo "PKS GU-ID is: $pksguid"

if [ -z "$1" ]; then
    echo "IP not given...trying to retrieve PKS API Public IP...";

    IP=$( aws --region us-east-1 ec2 describe-instances --filters 'Name=tag:deployment,Values='"$pksguid"'' \
      --query 'Reservations[*].Instances[*].[PublicIpAddress]' --output text )
else
    IP="$1"
fi
echo "IP to update: $IP"

HOSTED_ZONE_ID=$( aws route53 list-hosted-zones-by-name | jq --arg name "thecloudgarage.com." -r '.HostedZones | .[] | select(.Name=="\($name)") | .Id' | sed -r 's/.{12}//' )

echo "Hosted zone being modified: $HOSTED_ZONE_ID"

INPUT_JSON=$( cat ./aws-route53-tanzu-tkg-i.json | sed "s/127\.0\.0\.1/$IP/" )

INPUT_JSON="{ \"ChangeBatch\": $INPUT_JSON }"

aws route53 change-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --cli-input-json "$INPUT_JSON"

cat aws-route53-tanzu-tkg-i.json | sed "s/'$IP'/127\.0\.0\.1/g"
