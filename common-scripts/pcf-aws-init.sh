#!/bin/bash

#SET VARIABLES FOR TILE NAMES TO BE DOWNLOADED FROM PIVOTAL NETWORK

echo Please provide your Pivnet token
read -e -p "pivnetToken: " -i "whatisyourtoken" pivnetToken

#SPECIFIY REQUIRED STEMCELLS (HARDENED OS) TO RUN VARIOUS WORKLOADS AND PLATFORM COMPONENTS

export stemcell456PivnetUrl=https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/579634/product_files/613151/download
export stemcell456PivnetProductName=light-bosh-stemcell-456.98-aws-xen-hvm-ubuntu-xenial-go_agent.tgz
export stemcell621PivnetUrl=https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/630534/product_files/667978/download
export stemcell621PivnetProductName=light-bosh-stemcell-621.71-aws-xen-hvm-ubuntu-xenial-go_agent.tgz
export stemcell315PivnetUrl=https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/626507/product_files/663626/download
export stemcell315PivnetProductName=light-bosh-stemcell-315.179-aws-xen-hvm-ubuntu-xenial-go_agent.tgz

#SPECIFY REQUIRED PRODUCTS (TILES) FROM PIVOTAL NETWORK

export pasPivnetUrl=https://network.pivotal.io/api/v2/products/elastic-runtime/releases/582590/product_files/616376/download
export pasPivnetProductName=cf-2.8.4-build.16.pivotal
export pksPivnetUrl=https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/551663/product_files/582811/download
export pksPivnetProductName=pivotal-container-service-1.6.1-build.6.pivotal
export harborPivnetUrl=: " -i "https://network.pivotal.io/api/v2/products/harbor-container-registry/releases/579832/product_files/613396/download" harborPivnetUrl
read -e -p "harborPivnetProductName: " -i "harbor-container-registry-1.10.1-build.7.pivotal" harborPivnetProductName
read -e -p "mysqlPivnetUrl: " -i "https://network.pivotal.io/api/v2/products/pivotal-mysql/releases/584606/product_files/618567/download" mysqlPivnetUrl
read -e -p "mysqlPivnetProductName: " -i "pivotal-mysql-2.7.6-build.21.pivotal" mysqlPivnetProductName

#DOWNLOAD REQUIRED STEMCELLS (HARDENED OS) TO RUN VARIOUS WORKLOADS AND PLATFORM COMPONENTS
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $stemcell456PivnetUrl -O "$stemcell456PivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $stemcell621PivnetUrl -O "$stemcell621PivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $stemcell315PivnetUrl -O "$stemcell315PivnetProductName"

#DOWNLOAD REQUIRED PRODUCTS (TILES) FROM PIVOTAL NETWORK
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $pasPivnetUrl -O "$pasPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $pksPivnetUrl -O "$pksPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $harborPivnetUrl -O "$harborPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $mysqlPivnetUrl -O "$mysqlPivnetProductName"

#DERIVE THE UAA AUTHENTICATION TOKEN FOR OPS MANAGER

export uaaToken=$( sudo curl -s -k -H 'Accept: application/json;charset=utf-8' -d 'grant_type=password' -d 'username=admin' -d 'password=admin' \
  -u 'opsman:' https://localhost/uaa/oauth/token |  jq --raw-output '.access_token' )

#UPLOAD THE STEMCELLS TO OPS MANAGER

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/stemcells -F \
  'stemcell[file]=@'"$stemcell456PivnetProductName"''
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/stemcells -F \
  'stemcell[file]=@'"$stemcell621PivnetProductName"''
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/stemcells -F \
  'stemcell[file]=@'"$stemcell315PivnetProductName"''

#UPLOAD THE PRODUCT TILES TO OPS MANAGER
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$pasPivnetProductName"''
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$pksPivnetProductName"''
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$harborPivnetProductName"''
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$mysqlPivnetProductName"''
  
#DISABLE THE WILDCARD VERFIER FOR PIVOTAL APPLICATION SERVICE AS DNS IS NOT YET SETUP

#DERIVE THE GU-ID FOR PIVOTAL APPLICATION SERVICE PRODUCT TILE
export pasguid=$( curl "https://localhost/api/v0/staged/products" -k \
  -X GET \
  -H 'Authorization: Bearer '"$uaaToken"'' \
  | jq --raw-output '.[] | select(.installation_name|test("cf.")) | .guid' )

echo "PAS GU-ID is: $pasguid"

#THEN DISABLE THE DNS WILDCARD DOMAIN VERIFIER
curl "https://localhost/api/v0/staged/products/$pasguid/verifiers/install_time/WildcardDomainVerifier" -k \
-X PUT \
-H 'Authorization: Bearer '"$uaaToken"'' \
-H "Content-Type: application/json" \
-d '{ "enabled": false }'
