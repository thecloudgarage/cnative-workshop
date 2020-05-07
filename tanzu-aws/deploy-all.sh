#!/bin/bash
echo Please provide your Pivnet token
read -e -p "pivnetToken: " -i "what is your pivotal token" pivnetToken
sudo sed 's/pivnetToken/$pivnetToken/g' aws-tanzu-opsman-ec2-user-data-without-route53.sh > temp.sh && mv temp.sh aws-tanzu-opsman-ec2-user-data-without-route53.sh
cd terraform-tanzu-aws
sudo terraform init
sudo terraform plan
sudo terraform apply -auto-approve
sudo terraform output
