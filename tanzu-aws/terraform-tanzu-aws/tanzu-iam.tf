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
