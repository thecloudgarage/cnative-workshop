#!/bin/sh

if [ -z "$1" ]; then 
    echo "IP not given...trying EC2 metadata...";
    IP=$( curl http://169.254.169.254/latest/meta-data/public-ipv4 )  
else 
    IP="$1" 
fi 
echo "IP to update: $IP"

HOSTED_ZONE_ID=$( aws route53 list-hosted-zones-by-name | grep -B 1 -e "thecloudgarage.com" | sed 's/.*hostedzone\/\([A-Za-z0-9]*\)\".*/\1/' | head -n 1 )
echo "Hosted zone being modified: $HOSTED_ZONE_ID"

#!/bin/bash
IP=$( aws --region us-east-1 ec2 describe-instances --filters 'Name=tag:Name,Values=opsman' --query 'Reservations[*].Ins
tances[*].[PublicIpAddress]' --output text )

INPUT_JSON=$( cat ./route53-opsman.json | sed "s/127\.0\.0\.1/$IP/" )

INPUT_JSON="{ \"ChangeBatch\": $INPUT_JSON }"

aws route53 change-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --cli-input-json "$INPUT_JSON"
