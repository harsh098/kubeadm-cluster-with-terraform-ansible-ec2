resource "aws_subnet" "cluster_subnet" {
  vpc_id                  = aws_vpc.k8s-vpc.id
  cidr_block              = var.cidr_subnet
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.k8s_name}"
    Type = "Public"
  }
}