#!/bin/bash
cd terraform-tanzu-aws
sudo terraform destroy -auto-approve
sudo rm -rf terra*
sudo rm -rf .terraform

