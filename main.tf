terraform {
  required_version = ">= 0.11.5"
}

// We need an AWS credentials
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

// Generates an IAM policy document in JSON format
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

// Lets creates an IAM Role and Instance Profile with a necessary permission required for Consul Auto-Join
resource "aws_iam_role" "consul" {
  name_prefix        = "${var.name}-"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

data "aws_iam_policy_document" "consul" {
  statement {
    sid       = "AllowSelfAssembly"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "ec2:DescribeVpcs",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
    ]
  }
}

// Generates an IAM policy document in JSON format
resource "aws_iam_role_policy" "consul" {
  name_prefix = "${var.name}-"
  role        = "${aws_iam_role.consul.id}"
  policy      = "${data.aws_iam_policy_document.consul.json}"
}

// This will provides an IAM instance profile.
resource "aws_iam_instance_profile" "consul" {
  name_prefix = "${var.name}-"
  role        = "${aws_iam_role.consul.name}"
}

// Here we create the Consul servers
resource "aws_instance" "server" {
  ami                         = "${var.consul_version}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  count                       = "${var.server_count}"
  private_ip                  = "172.31.${var.dc_net}.${count.index + 11}"
  subnet_id                   = "${var.subnet}"
  iam_instance_profile        = "${aws_iam_instance_profile.consul.id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${var.vpc_security_group_id}"]

  // Consul tag consul = "app" we need it for AWS Consul Auto-Join
  tags = {
    Name       = "consul-server0${count.index + 1}"
    consul     = "app"
    consul_wan = "wan_app"
  }

  // Our private key needed for connection to the servers 
  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host        = self.public_ip // tf12
  }

  provisioner "file" {
    source      = "${path.module}/scripts/consul.sh"
    destination = "/tmp/consul.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${var.dcname}",
      "sudo bash /tmp/consul.sh ${var.dcname}",
    ]
  }
}

// The output of the consul agents
output "public_dns_servers" {
  value = "${aws_instance.server.*.public_dns}"
}

output "subnet_id" {
  value = "${aws_instance.server.*.subnet_id}"
}

output "instance_type" {
  value = "${aws_instance.server.*.instance_type}"
}

output "availability_zone" {
  value = "${aws_instance.server.*.availability_zone}"
}

output "key_name" {
  value = "${aws_instance.server.*.key_name}"
}

output "aws_iam_instance_profile" {
  value = "${aws_iam_instance_profile.consul.*.id}"
}

output "consul_tag" {
  value = "${aws_instance.server.*.tags.consul}"
}

output "ami_id" {
  value = "${aws_instance.server.*.ami}"
}

output "private_ip" {
  value = "${aws_instance.server.*.private_ip}"
}
