#!/bin/bash
if [ -z "$1" ]; then
	    echo "IP not given...trying EC2 metadata...";
	        IP=$( curl http://169.254.169.254/latest/meta-data/public-ipv4 )
	else
		    IP="$1"
	    fi
	    echo "IP to update: $IP"

	    curl -k "https://$IP/api/v0/setup" \
		      -X POST \
		        -H "Content-Type: application/json" \
			  -d '{ "setup": {
	      "decryption_passphrase": "admin",
	        "decryption_passphrase_confirmation":"admin",
		  "eula_accepted": "true",
		    "identity_provider": "internal",
		      "admin_user_name": "admin",
		        "admin_password": "admin",
			  "admin_password_confirmation": "admin"
		  } }'
