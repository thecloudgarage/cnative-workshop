#!/bin/bash
IP=$( aws --region us-east-1 ec2 describe-instances --filters 'Name=tag:Name,Values=opsman' --query 'Reservations[*].Ins
tances[*].[PublicIpAddress]' --output text )

INPUT_JSON=$( cat ./route53-opsman.json | sed "s/127\.0\.0\.1/$IP/" )

INPUT_JSON="{ \"ChangeBatch\": $INPUT_JSON }"

aws route53 change-resource-record-sets --hosted-zone-id ZNWXG1JHHXS3J --cli-input-json "$INPUT_JSON"
