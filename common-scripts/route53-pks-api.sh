#!/bin/sh

if [ -z "$1" ]; then 
    echo "IP not given...trying EC2 metadata...";
    IP=$( aws --region us-east-1 ec2 describe-instances --filters 'Name=private-ip-address,Values=10.0.1.11' --query 'Reservations[*].Instances[*].[PublicIpAddress]' --output text )  
else 
    IP="$1" 
fi 
echo "IP to update: $IP"

HOSTED_ZONE_ID=$( aws route53 list-hosted-zones-by-name | jq --arg name "thecloudgarage.com." -r '.HostedZones | .[] | select(.Name=="\($name)") | .Id' | sed -r 's/.{12}//' )
echo "Hosted zone being modified: $HOSTED_ZONE_ID"

INPUT_JSON=$( cat ./route53-pks-api.json | sed "s/127\.0\.0\.1/$IP/" )

INPUT_JSON="{ \"ChangeBatch\": $INPUT_JSON }"

aws route53 change-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --cli-input-json "$INPUT_JSON"


