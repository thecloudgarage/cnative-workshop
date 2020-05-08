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
