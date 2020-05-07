output "TANZU_VPC_id" {
  value = "${aws_vpc.TANZU_VPC.id}"
}
output "TANZU_VPC_INFRA_AZ1_SUBNET_ID" {
  value = "${aws_subnet.TANZU_VPC_INFRA_AZ1.id}"
}
output "TANZU_VPC_INFRA_AZ2_SUBNET_ID" {
  value = "${aws_subnet.TANZU_VPC_INFRA_AZ2.id}"
}
output "TANZU_VPC_TAS_AZ1_SUBNET_ID" {
  value = "${aws_subnet.TANZU_VPC_TAS_AZ1.id}"
}
output "TANZU_VPC_TAS_AZ2_SUBNET_ID" {
  value = "${aws_subnet.TANZU_VPC_TAS_AZ2.id}"
}
output "TANZU_VPC_TKG_I_AZ1_SUBNET_ID" {
  value = "${aws_subnet.TANZU_VPC_TKG_I_AZ1.id}"
}
output "TANZU_VPC_TKG_I_AZ2_SUBNET_ID" {
  value = "${aws_subnet.TANZU_VPC_TKG_I_AZ2.id}"
}
output "TANZU_VPC_SERVICES_AZ1_SUBNET_ID" {
  value = "${aws_subnet.TANZU_VPC_SERVICES_AZ1.id}"
}
output "TANZU_VPC_SERVICES_AZ2_SUBNET_ID" {
  value = "${aws_subnet.TANZU_VPC_SERVICES_AZ2.id}"
}
output "TANZU_VPC_INFRA_AZ1_SUBNET_CIDR" {
  value = "${var.ipINFRA_AZ1}"
}
output "TANZU_VPC_INFRA_AZ2_SUBNET_CIDR" {
  value = "${var.ipINFRA_AZ2}"
}
output "TANZU_VPC_TAS_AZ1_SUBNET_CIDR" {
  value = "${var.ipTAS_AZ1}"
}
output "TANZU_VPC_TAS_AZ2_SUBNET_CIDR" {
  value = "${var.ipTAS_AZ2}"
}
output "TANZU_VPC_TKG_I_AZ1_SUBNET_CIDR" {
  value = "${var.ipTKG_I_AZ1}"
}
output "TANZU_VPC_TKG_I_AZ2_SUBNET_CIDR" {
  value = "${var.ipTKG_I_AZ2}"
}
output "TANZU_VPC_SERVICES_AZ1_SUBNET_CIDR" {
  value = "${var.ipSERVICES_AZ1}"
}
output "TANZU_VPC_SERVICES_AZ2_SUBNET_CIDR" {
  value = "${var.ipSERVICES_AZ2}"
}
output "TANZU_VPC_SECURITY_GROUP_ID" {
  value = ["${aws_security_group.TANZU_VPC_Security_Group.id}"]
}
output "TANZU_OPS_MANAGER_PUBLIC_IP" {
  value       = "${aws_instance.TANZU_OPS_MANAGER.*.public_ip}"
  description = "The public IP of the TANZU OPS MANAGER"
}
output "TANZU_IAM_USER_ID" {
  value = "${aws_iam_user.TANZU_IAM_USER.id}"
}

output "TANZU_IAM_USER_ARN" {
  value = "${aws_iam_user.TANZU_IAM_USER.arn}"
}

output "TANZU_IAM_USER_NAME" {
  value = "${aws_iam_user.TANZU_IAM_USER.name}"
}

output "TANZU_USER_access_key_id" {
  value = "${aws_iam_access_key.access_key.id}"
}

output "TANZU_USER_access_key_secret" {
  value = "${aws_iam_access_key.access_key.secret}"
}

output "TANZU_IAM_ROLE" {
  value = "${aws_iam_role.TANZU_IAM_ROLE.name}"
}

output "TANZU_IAM_INSTANCE_PROFILE" {
  value = "${aws_iam_instance_profile.TANZU_IAM_INSTANCE_PROFILE.name}"
}
