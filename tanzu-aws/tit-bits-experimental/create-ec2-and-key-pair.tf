provider "aws" {
  region = "us-east-1"
}
resource "tls_private_key" "key" {
  algorithm = "RSA"
}
 
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
resource "aws_instance" "web" {
  ami                    = "ami-0323c3dd2da7fb37d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-1d98356c"]
  key_name      = "${aws_key_pair.key_tf.key_name}"
}
