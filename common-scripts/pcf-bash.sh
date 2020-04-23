#!/bin/bash
export uaaToken=$( sudo curl -s -k -H 'Accept: application/json;charset=utf-8' -d 'grant_type=password' -d 'username=admin' -d 'password=admin' \
  -u 'opsman:' https://localhost/uaa/oauth/token |  jq --raw-output '.access_token' )
echo Please provide your Pivnet token
read -e -p "pivnetToken: " -i "whatisyourtoken" pivnetToken
read -e -p "pasPivnetUrl: " -i "https://network.pivotal.io/api/v2/products/elastic-runtime/releases/582590/product_files/616376/download" pasPivnetUrl
read -e -p "pasPivnetProductName: " -i "cf-2.8.4-build.16.pivotal" pasPivnetProductName
read -e -p "pksPivnetUrl: " -i "https://network.pivotal.io/api/v2/products/pivotal-container-service/releases/551663/product_files/582811/download" pksPivnetUrl
read -e -p "pksPivnetProductName: " -i "pivotal-container-service-1.6.1-build.6.pivotal" pksPivnetProductName
read -e -p "harborPivnetUrl: " -i "https://network.pivotal.io/api/v2/products/harbor-container-registry/releases/579832/product_files/613396/download" harborPivnetUrl
read -e -p "harborPivnetProductName: " -i "harbor-container-registry-1.10.1-build.7.pivotal" harborPivnetProductName
read -e -p "stemcellPivnetUrl: " -i "https://network.pivotal.io/api/v2/products/stemcells-ubuntu-xenial/releases/579634/product_files/613151/download" \
  stemcellPivnetUrl
read -e -p "stemcellPivnetProductName: " -i "light-bosh-stemcell-456.98-aws-xen-hvm-ubuntu-xenial-go_agent.tgz" stemcellPivnetProductName
read -e -p "mysqlPivnetUrl: " -i "https://network.pivotal.io/api/v2/products/pivotal-mysql/releases/584606/product_files/618567/download" mysqlPivnetUrl
read -e -p "mysqlPivnetProductName: " -i "pivotal-mysql-2.7.6-build.21.pivotal" mysqlPivnetProductName
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $pasPivnetUrl -O "$pasPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $pksPivnetUrl -O "$pksPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $harborPivnetUrl -O "$harborPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $stemcellPivnetUrl -O "$stemcellPivnetProductName"
sudo wget --post-data="" --header="Authorization: Token $pivnetToken" $mysqlPivnetUrl -O "$mysqlPivnetProductName"
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/stemcells -F \
  'stemcell[file]=@'"$stemcellPivnetProductName"''
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
'product[file]=@'"$pasPivnetProductName"''
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
'product[file]=@'"$pksPivnetProductName"''
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
'product[file]=@'"$harborPivnetProductName"''
sudo curl -vv --progress-bar -H 'Authorization: bearer '"$uaaToken"'' -k -X POST https://localhost/api/v0/available_products -F \
'product[file]=@'"$mysqlPivnetProductName"''
