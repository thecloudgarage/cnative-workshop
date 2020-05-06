#!/bin/bash
cd /home/ubuntu
sudo git clone https://github.com/thecloudgarage/cnative-workshop.git
cd /home/ubuntu/cnative-workshop/common-scripts/
sudo sed 's/your-legacy-api-token/Ex58-tDkfHxszQQRNdKf/g' aws-route53-tanzu-opsman.sh > temp.sh && mv temp.sh aws-route53-tanzu-opsman.sh
sudo sed 's/your-legacy-api-token/Ex58-tDkfHxszQQRNdKf/g' aws-install-tools.sh > temp.sh && mv temp.sh aws-install-tools.sh
sudo chmod +x aws-tanzu-opsman-deploy.sh
sudo chmod +x aws-install-tools.sh
sudo ./aws-install-tools.sh
sudo chmod +x aws-route53-tanzu-opsman.sh
sudo ./aws-route53-tanzu-opsman.sh
sudo chmod +x tanzu-tas-disable-wildcard-verifier.sh
sudo ./tanzu-tas-disable-wildcard-verifier.sh
