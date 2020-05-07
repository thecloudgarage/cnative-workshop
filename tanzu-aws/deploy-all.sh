#!/bin/bash
cd terraform-tanzu-aws
sudo terraform init
sudo terraform plan
sudo terraform apply -auto-approve
sudo terraform output
