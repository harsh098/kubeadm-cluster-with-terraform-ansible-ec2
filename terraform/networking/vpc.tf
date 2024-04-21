resource "aws_vpc" "k8s-vpc" {
  cidr_block = var.cidr_vpc
  enable_dns_hostnames = true
  tags = {
    Name = "${var.k8s_name}"
  }
}