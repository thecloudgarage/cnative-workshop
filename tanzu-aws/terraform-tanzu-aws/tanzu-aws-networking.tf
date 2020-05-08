# Create VPC/Subnet/Security Group/ACL
provider "aws" {
        region     = "${var.region}"
} # end provider

# create the VPC
resource "aws_vpc" "TANZU_VPC" {
  cidr_block           = "${var.vpcCIDRblock}"
  instance_tenancy     = "${var.instanceTenancy}"
  enable_dns_support   = "${var.dnsSupport}"
  enable_dns_hostnames = "${var.dnsHostNames}"
tags = {
    Name = "TANZU_VPC"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "TANZU_VPC_INFRA_AZ1" {
  vpc_id                  = "${aws_vpc.TANZU_VPC.id}"
  cidr_block              = "${var.ipINFRA_AZ1}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone       = "${var.AZ1}"
tags = {
   Name = "TANZU_VPC_INFRA_AZ1"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "TANZU_VPC_INFRA_AZ2" {
  vpc_id                  = "${aws_vpc.TANZU_VPC.id}"
  cidr_block              = "${var.ipINFRA_AZ2}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone       = "${var.AZ2}"
tags = {
   Name = "TANZU_VPC_INFRA_AZ2"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "TANZU_VPC_TAS_AZ1" {
  vpc_id                  = "${aws_vpc.TANZU_VPC.id}"
  cidr_block              = "${var.ipTAS_AZ1}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone       = "${var.AZ1}"
tags = {
   Name = "TANZU_VPC_TAS_AZ1"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "TANZU_VPC_TAS_AZ2" {
  vpc_id                  = "${aws_vpc.TANZU_VPC.id}"
  cidr_block              = "${var.ipTAS_AZ2}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone       = "${var.AZ2}"
tags = {
   Name = "TANZU_VPC_TAS_AZ2"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "TANZU_VPC_TKG_I_AZ1" {
  vpc_id                  = "${aws_vpc.TANZU_VPC.id}"
  cidr_block              = "${var.ipTKG_I_AZ1}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone       = "${var.AZ1}"
tags = {
   Name = "TANZU_VPC_TKG_I_AZ1"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "TANZU_VPC_TKG_I_AZ2" {
  vpc_id                  = "${aws_vpc.TANZU_VPC.id}"
  cidr_block              = "${var.ipTKG_I_AZ2}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone       = "${var.AZ1}"
tags = {
   Name = "TANZU_VPC_TKG_I_AZ2"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "TANZU_VPC_SERVICES_AZ1" {
  vpc_id                  = "${aws_vpc.TANZU_VPC.id}"
  cidr_block              = "${var.ipSERVICES_AZ1}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone       = "${var.AZ1}"
tags = {
   Name = "TANZU_VPC_SERVICES_AZ1"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "TANZU_VPC_SERVICES_AZ2" {
  vpc_id                  = "${aws_vpc.TANZU_VPC.id}"
  cidr_block              = "${var.ipSERVICES_AZ2}"
  map_public_ip_on_launch = "${var.mapPublicIP}"
  availability_zone       = "${var.AZ2}"
tags = {
   Name = "TANZU_VPC_SERVICES_AZ2"
  }
} # end resource

# Create the Security Group
resource "aws_security_group" "TANZU_VPC_Security_Group" {
  vpc_id       = "${aws_vpc.TANZU_VPC.id}"
  name         = "PCF_VPC_Security_Group"
  description  = "PCF_VPC_Security_Group"
ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
tags = {
        Name = "TANZU_VPC_Security_Group"
  }
}
# end resource

# create VPC Network access control list
resource "aws_network_acl" "TANZU_VPC_Security_ACL" {
  vpc_id = "${aws_vpc.TANZU_VPC.id}"
  subnet_ids = [ "${aws_subnet.TANZU_VPC_INFRA_AZ1.id}","${aws_subnet.TANZU_VPC_INFRA_AZ2.id}","${aws_subnet.TANZU_VPC_TAS_AZ1.id}","${aws_subnet.TANZU_VPC_TAS_AZ2.id
}","${aws_subnet.TANZU_VPC_TKG_I_AZ1.id}","${aws_subnet.TANZU_VPC_TKG_I_AZ2.id}","${aws_subnet.TANZU_VPC_SERVICES_AZ1.id}","${aws_subnet.TANZU_VPC_SERVICES_AZ2.id}" ]
# allow port 22
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
tags = {
    Name = "TANZU_VPC_Security_ACL"
  }
} # end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "TANZU_VPC_IGW" {
  vpc_id = "${aws_vpc.TANZU_VPC.id}"
tags = {
        Name = "TANZU_VPC_IGW"
    }
} # end resource
# Create the Route Table
resource "aws_route_table" "TANZU_VPC_RT" {
    vpc_id = "${aws_vpc.TANZU_VPC.id}"
tags = {
        Name = "TANZU_VPC_RT"
    }
} # end resource

# Create the Internet Access
resource "aws_route" "TANZU_VPC_internet_access" {
  route_table_id        = "${aws_route_table.TANZU_VPC_RT.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.TANZU_VPC_IGW.id}"
} # end resource
# Associate the Route Table with the Subnet
resource "aws_route_table_association" "TANZU_VPC_INFRA_AZ1_association" {
    subnet_id      = "${aws_subnet.TANZU_VPC_INFRA_AZ1.id}"
    route_table_id = "${aws_route_table.TANZU_VPC_RT.id}"
} # end resource
resource "aws_route_table_association" "TANZU_VPC_INFRA_AZ2_association" {
    subnet_id      = "${aws_subnet.TANZU_VPC_INFRA_AZ2.id}"
    route_table_id = "${aws_route_table.TANZU_VPC_RT.id}"
} # end resource
resource "aws_route_table_association" "TANZU_VPC_TAS_AZ1_association" {
    subnet_id      = "${aws_subnet.TANZU_VPC_TAS_AZ1.id}"
    route_table_id = "${aws_route_table.TANZU_VPC_RT.id}"
} # end resource
resource "aws_route_table_association" "TANZU_VPC_TAS_AZ2_association" {
    subnet_id      = "${aws_subnet.TANZU_VPC_TAS_AZ2.id}"
    route_table_id = "${aws_route_table.TANZU_VPC_RT.id}"
} # end resource
resource "aws_route_table_association" "TANZU_VPC_TKG_I_AZ1_association" {
    subnet_id      = "${aws_subnet.TANZU_VPC_TKG_I_AZ1.id}"
    route_table_id = "${aws_route_table.TANZU_VPC_RT.id}"
} # end resource
resource "aws_route_table_association" "TANZU_VPC_TKG_I_AZ2_association" {
    subnet_id      = "${aws_subnet.TANZU_VPC_TKG_I_AZ2.id}"
    route_table_id = "${aws_route_table.TANZU_VPC_RT.id}"
} # end resource
resource "aws_route_table_association" "TANZU_VPC_SERVICES_AZ1_association" {
    subnet_id      = "${aws_subnet.TANZU_VPC_SERVICES_AZ1.id}"
    route_table_id = "${aws_route_table.TANZU_VPC_RT.id}"
} # end resource
resource "aws_route_table_association" "TANZU_VPC_SERVICES_AZ2_association" {
    subnet_id      = "${aws_subnet.TANZU_VPC_SERVICES_AZ2.id}"
    route_table_id = "${aws_route_table.TANZU_VPC_RT.id}"
} # end resource

