#!/bin/bash
cd /home/ubuntu
sudo git clone https://github.com/thecloudgarage/cnative-workshop.git
cd /home/ubuntu/cnative-workshop/tanzu-aws/
sudo sed 's/your-legacy-api-token/Ex58-tDkfHxszQQRNdKf/g' aws-tanzu-opsman-deploy.sh > temp.sh && mv temp.sh aws-tanzu-opsman-deploy.sh
sudo sed 's/your-legacy-api-token/Ex58-tDkfHxszQQRNdKf/g' aws-install-tools.sh > temp.sh && mv temp.sh aws-install-tools.sh
sudo chmod +x aws-install-tools.sh
sudo ./aws-install-tools.sh
sudo chmod +x aws-route53-tanzu-opsman.sh
sudo ./aws-route53-tanzu-opsman.sh
sudo chmod +x aws-tanzu-opsman-start-uaa.sh
sudo ./aws-tanzu-opsman-start-uaa.sh
sleep 2m
sudo chmod +x aws-tanzu-opsman-deploy.sh
sudo ./aws-tanzu-opsman-deploy.sh
sudo chmod +x tanzu-tas-disable-wildcard-verifier.sh
sudo ./tanzu-tas-disable-wildcard-verifier.sh
