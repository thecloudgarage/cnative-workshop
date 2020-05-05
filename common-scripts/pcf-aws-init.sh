#!/bin/bash

export pivnetToken=your-legacy-api-token

#SET VARIABLES FOR TILE NAMES TO BE DOWNLOADED FROM PIVOTAL NETWORK

#SPECIFIY REQUIRED STEMCELLS (HARDENED OS) TO RUN VARIOUS WORKLOADS AND PLATFORM COMPONENTS

export stemcell456PivnetUrl=https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/579634/product_files/613151/download
export stemcell456PivnetProductName=light-bosh-stemcell-456.98-aws-xen-hvm-ubuntu-xenial-go_agent.tgz
export stemcell621PivnetUrl=https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/630534/product_files/667978/download
export stemcell621PivnetProductName=light-bosh-stemcell-621.71-aws-xen-hvm-ubuntu-xenial-go_agent.tgz
export stemcell315PivnetUrl=https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/626507/product_files/663626/download
export stemcell315PivnetProductName=light-bosh-stemcell-315.179-aws-xen-hvm-ubuntu-xenial-go_agent.tgz
export stemcell2019PivnetUrl=https://network.pivotal.io/api/v2/products/stemcells-windows-server/releases/630457/product_files/666943/download
export stemcell2019PivnetProductName=light-bosh-stemcell-2019.20-aws-xen-hvm-windows2019-go_agent.tgz
export stemcell250PivnetUrl=https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/630535/product_files/667986/download
export stemcell250PivnetProductName=light-bosh-stemcell-250.196-aws-xen-hvm-ubuntu-xenial-go_agent.tgz

#SPECIFY REQUIRED PRODUCTS (TILES) FROM PIVOTAL NETWORK

export pasPivnetUrl=https://network.pivotal.io/api/v2/products/elastic-runtime/releases/582590/product_files/616376/download
export pasPivnetProductName=cf-2.8.4-build.16.pivotal
export pksPivnetUrl=https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/551663/product_files/582811/download
export pksPivnetProductName=pivotal-container-service-1.6.1-build.6.pivotal
export harborPivnetUrl=https://network.pivotal.io/api/v2/products/harbor-container-registry/releases/579832/product_files/613396/download
export harborPivnetProductName=harbor-container-registry-1.10.1-build.7.pivotal
export mysqlPivnetUrl=https://network.pivotal.io/api/v2/products/pivotal-mysql/releases/584606/product_files/618567/download
export mysqlPivnetProductName=pivotal-mysql-2.7.6-build.21.pivotal
export rabbitmqPivnetUrl=https://network.pivotal.io/api/v2/products/p-rabbitmq/releases/601550/product_files/636892/download
export rabbitmqPivnetProductName=p-rabbitmq-1.18.4-build.83.pivotal
export paswindowsPivnetUrl=https://network.pivotal.io/api/v2/products/pas-windows/releases/625232/product_files/662163/download
export paswindowsPivnetProductName=pas-windows-2.9.1-build.2.pivotal
export redisPivnetUrl=https://network.pivotal.io/api/v2/products/p-redis/releases/626432/product_files/663536/download
export redisPivnetProductName=p-redis-2.3.3-build.2.pivotal
export awsservicebrokerPivnetUrl=https://network.pivotal.io/api/v2/products/aws-services/releases/567835/product_files/600335/download
export awsservicebrokerPivnetProductName=aws-services-1.4.16.256.pivotal

#ACCEPT EULA FOR UBUNTU STEMCELL 456 ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/579634/eula_acceptance

#ACCEPT EULA FOR UBUNTU STEMCELL 621 ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/630534/eula_acceptance

#ACCEPT EULA FOR UBUNTU STEMCELL 315 ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/626507/eula_acceptance

#ACCEPT EULA FOR WINDOWS STEMCELL 2019 ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/stemcells-windows-server/releases/630457/eula_acceptance

#ACCEPT EULA FOR UBUNTU STEMCELL 250 ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/630535/eula_acceptance

#ACCEPT EULA FOR TANZU APPLICATION SERVICE ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/elastic-runtime/releases/582590/eula_acceptance

#ACCEPT EULA FOR TANZU KUBERNETES GRID-INTEGRATED (ERSTWHILE ENTERPRISE PKS) ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/551663/eula_acceptance

#ACCEPT EULA FOR HARBOR ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/harbor-container-registry/releases/579832/eula_acceptance

#ACCEPT EULA FOR MYSQL ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/pivotal-mysql/releases/584606/eula_acceptance

#ACCEPT EULA FOR RABBITMQ ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/p-rabbitmq/releases/601550/eula_acceptance

#ACCEPT EULA FOR TANZU APPLICATION SERVICE (WINDOWS) ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/pas-windows/releases/625232/eula_acceptance

#ACCEPT EULA FOR REDIS ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/p-redis/releases/626432/eula_acceptance

#ACCEPT EULA FOR AWS SERVICE BROKER ON PIVOTAL NETWORK

curl -i -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -H 'Authorization: Token '"$pivnetToken"'' \
  -X POST https://network.pivotal.io/api/v2/products/aws-services/releases/567835/eula_acceptance


#DOWNLOAD REQUIRED STEMCELLS (HARDENED OS) TO RUN VARIOUS WORKLOADS AND PLATFORM COMPONENTS
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $stemcell456PivnetUrl -O "$stemcell456PivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $stemcell621PivnetUrl -O "$stemcell621PivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $stemcell315PivnetUrl -O "$stemcell315PivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $stemcell2019PivnetUrl -O "$stemcell2019PivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $stemcell250PivnetUrl -O "$stemcell250PivnetProductName"

#DOWNLOAD REQUIRED PRODUCTS (TILES) FROM PIVOTAL NETWORK
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $pasPivnetUrl -O "$pasPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $pksPivnetUrl -O "$pksPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $harborPivnetUrl -O "$harborPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $mysqlPivnetUrl -O "$mysqlPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $rabbitmqPivnetUrl -O "$rabbitmqPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $paswindowsPivnetUrl -O "$paswindowsPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $redisPivnetUrl -O "$redisPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $awsservicebrokerPivnetUrl -O "$awsservicebrokerPivnetProductName"

#DERIVE THE UAA AUTHENTICATION TOKEN FOR OPS MANAGER

export uaaToken=$( sudo curl -s -k -H 'Accept: application/json;charset=utf-8' -d 'grant_type=password' -d 'username=admin' -d 'password=admin' \
  -u 'opsman:' https://localhost/uaa/oauth/token |  jq --raw-output '.access_token' )

#UPLOAD THE STEMCELLS TO OPS MANAGER

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/stemcells -F \
  'stemcell[file]=@'"$stemcell456PivnetProductName"''
sudo rm -rf $stemcell456PivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/stemcells -F \
  'stemcell[file]=@'"$stemcell621PivnetProductName"''
sudo rm -rf $stemcell621PivnetProductName  

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/stemcells -F \
  'stemcell[file]=@'"$stemcell315PivnetProductName"''
sudo rm -rf $stemcell315PivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/stemcells -F \
  'stemcell[file]=@'"$stemcell2109PivnetProductName"''
sudo rm -rf $stemcell2019PivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/stemcells -F \
  'stemcell[file]=@'"$stemcell250PivnetProductName"''  
sudo rm -rf $stemcell250PivnetProductName

#UPLOAD THE PRODUCT TILES TO OPS MANAGER
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$pasPivnetProductName"''
sudo rm -rf $pasPivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$pksPivnetProductName"''
sudo rm -rf $pksPivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$harborPivnetProductName"''
sudo rm -rf $harborPivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$mysqlPivnetProductName"''
sudo rm -rf $mysqlPivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$rabbitmqPivnetProductName"''
sudo rm -rf $rabbitmqPivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$paswindowsPivnetProductName"''  
sudo rm -rf $paswindowsPivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$redisPivnetProductName"''
sudo rm -rf $redisPivnetProductName

sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
  'product[file]=@'"$awsservicebrokerPivnetProductName"''
sudo rm -rf $awsservicebrokerPivnetProductName

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
