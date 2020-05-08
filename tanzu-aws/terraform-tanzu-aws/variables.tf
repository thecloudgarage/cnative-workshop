# variables.tf
variable "region" {
 default = "us-east-1"
}
variable "instanceTenancy" {
 default = "default"
}
variable "dnsSupport" {
 default = true
}
variable "dnsHostNames" {
        default = true
}
variable "vpcCIDRblock" {
 default = "10.0.0.0/16"
}
variable "mapPublicIP" {
        default = true
}
variable "AZ1" {
 default = "us-east-1a"
}
variable "AZ2" {
 default = "us-east-1b"
}
variable "ipINFRA_AZ1" {
 default = "10.0.1.0/24"
}
variable "ipINFRA_AZ2" {
 default = "10.0.2.0/24"
}
variable "ipTAS_AZ1" {
 default = "10.0.11.0/24"
}
variable "ipTAS_AZ2" {
 default = "10.0.12.0/24"
}
variable "ipTKG_I_AZ1" {
 default = "10.0.21.0/24"
}
variable "ipTKG_I_AZ2" {
 default = "10.0.22.0/24"
}
variable "ipSERVICES_AZ1" {
 default = "10.0.31.0/24"
}
variable "ipSERVICES_AZ2" {
 default = "10.0.32.0/24"
}
variable "TANZU_OPS_MANAGER_AMI" {
 default = "ami-0aac5f23906ab0036"
}
variable "TANZU_OPS_MANAGER_INSTANCE_TYPE" {
 default = "t2.medium"
}
variable "pivnetToken" {
 default = ""
}
# end of variables.tf

