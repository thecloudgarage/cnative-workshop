#!/bin/bash
cd /home/ubuntu
#FIND THE PUBLIC IP OF EC2 INSTANCE
if [ -z "$1" ]; then
	    echo "IP not given...trying EC2 metadata...";
	        IP=$( curl http://169.254.169.254/latest/meta-data/public-ipv4 )
	else
		    IP="$1"
	    fi
	    echo "IP to update: $IP"
#ADD A LOCAL ENTRY FOR DNS RESOLUTION TILL ACTUAL OPS MAN DNS MAPPINGS ARE DONE
sudo sed "\$a$IP tanzu-opsman.aws.thecloudgarage.com" /etc/hosts > /etc/hosts.temp && mv /etc/hosts.temp /etc/hosts
sudo git clone https://github.com/thecloudgarage/cnative-workshop.git
cd /home/ubuntu/cnative-workshop/tanzu-aws/
sudo sed 's/your-legacy-api-token/Ex58-tDkfHxszQQRNdKf/g' aws-tanzu-opsman-deploy.sh > temp.sh && mv temp.sh aws-tanzu-opsman-deploy.sh
sudo sed 's/your-legacy-api-token/Ex58-tDkfHxszQQRNdKf/g' aws-install-tools.sh > temp.sh && mv temp.sh aws-install-tools.sh
sudo chmod +x aws-install-tools.sh
sudo ./aws-install-tools.sh
sudo chmod +x aws-tanzu-opsman-start-uaa.sh
sudo ./aws-tanzu-opsman-start-uaa.sh
sleep 2m
sudo chmod +x aws-tanzu-opsman-deploy.sh
sudo ./aws-tanzu-opsman-deploy.sh
sudo chmod +x tanzu-tas-disable-wildcard-verifier.sh
sudo ./tanzu-tas-disable-wildcard-verifier.sh
