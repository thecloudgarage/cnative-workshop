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
