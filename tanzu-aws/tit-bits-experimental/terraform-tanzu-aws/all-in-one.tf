# vpc.tf

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
  subnet_ids = [ "${aws_subnet.TANZU_VPC_INFRA_AZ1.id}","${aws_subnet.TANZU_VPC_INFRA_AZ2.id}","${aws_subnet.TANZU_VPC_TAS_AZ1.id}","${aws_subnet.TANZU_VPC_TAS_AZ2.id}","${aws_subnet.TANZU_VPC_TKG_I_AZ1.id}","${aws_subnet.TANZU_VPC_TKG_I_AZ2.id}","${aws_subnet.TANZU_VPC_SERVICES_AZ1.id}","${aws_subnet.TANZU_VPC_SERVICES_AZ2.id}" ]
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
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

#create a local file with private key material
resource "local_file" "key_priv" {
  content  = "${tls_private_key.key.private_key_pem}"
  filename = "id_rsa"
}

resource "null_resource" "key_chown" {
  provisioner "local-exec" {
    command = "chmod 400 id_rsa"
  }

  depends_on = ["local_file.key_priv"]
}

#create the public key
resource "null_resource" "key_gen" {
  provisioner "local-exec" {
    command = "rm -f id_rsa.pub && ssh-keygen -y -f id_rsa > id_rsa.pub"
  }

  depends_on = ["local_file.key_priv"]
}

data "local_file" "key_pub" {
  filename = "id_rsa.pub"

  depends_on = ["null_resource.key_gen"]
}

resource "aws_key_pair" "key_tf" {
  public_key = "${data.local_file.key_pub.content}"
}

#create the user data script

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false
  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
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
    sudo sed 's/your-legacy-api-token/"${var.pivnetToken}"/g' aws-tanzu-opsman-deploy.sh > temp.sh && mv temp.sh aws-tanzu-opsman-deploy.sh
    sudo sed 's/your-legacy-api-token/"${var.pivnetToken}"/g' aws-install-tools.sh > temp.sh && mv temp.sh aws-install-tools.sh
    sudo chmod +x aws-install-tools.sh
    sudo ./aws-install-tools.sh
    sudo chmod +x aws-tanzu-opsman-start-uaa.sh
    sudo ./aws-tanzu-opsman-start-uaa.sh
    sleep 2m
    sudo chmod +x aws-tanzu-opsman-deploy.sh
    sudo ./aws-tanzu-opsman-deploy.sh
    sudo chmod +x tanzu-tas-disable-wildcard-verifier.sh
    sudo ./tanzu-tas-disable-wildcard-verifier.sh
    EOF
  }
}

#create the tanzu ops manager instance
resource "aws_instance" "TANZU_OPS_MANAGER" {
  depends_on             = ["aws_iam_instance_profile.TANZU_IAM_INSTANCE_PROFILE"]
  ami                    = "${var.TANZU_OPS_MANAGER_AMI}"
  instance_type          = "${var.TANZU_OPS_MANAGER_INSTANCE_TYPE}"
  iam_instance_profile = "${aws_iam_instance_profile.TANZU_IAM_INSTANCE_PROFILE.name}"
  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = "true"
  }
  vpc_security_group_ids = ["${aws_security_group.TANZU_VPC_Security_Group.id}"]
  key_name      = "${aws_key_pair.key_tf.key_name}"
  user_data = "${data.template_cloudinit_config.config.rendered}"
  subnet_id = "${aws_subnet.TANZU_VPC_INFRA_AZ1.id}"
  tags = {
    Name = "TANZU_OPS_MANAGER"
  }
}

#create the IAM role, instance profile and an admin user for various operations to be done by BOSH

resource "aws_iam_role" "TANZU_IAM_ROLE" {
  name               = "TANZU_IAM_ROLE"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "TANZU_IAM_INSTANCE_PROFILE" {
  name  = "TANZU_IAM_INSTANCE_PROFILE"
  role = "${aws_iam_role.TANZU_IAM_ROLE.name}"
}

resource "aws_iam_user" "TANZU_IAM_USER" {
    name = "TANZU_IAM_USER"
    path = "/"
}

resource "aws_iam_access_key" "access_key" {
    user = "${aws_iam_user.TANZU_IAM_USER.name}"
}

resource "aws_iam_policy" "TANZU_IAM_POLICY" {
    name = "TANZU_IAM_POLICY"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "TANZU_IAM_ROLE_POLICY_ATTACH" {
  name       = "TANZU_IAM_ROLE_POLICY_ATTACH"
  roles      = ["${aws_iam_role.TANZU_IAM_ROLE.name}"]
  users      = ["${aws_iam_user.TANZU_IAM_USER.name}"]
  policy_arn = "${aws_iam_policy.TANZU_IAM_POLICY.arn}"
}
