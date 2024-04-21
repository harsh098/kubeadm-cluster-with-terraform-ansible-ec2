resource "aws_internet_gateway" "k8s" {
  vpc_id = aws_vpc.k8s-vpc.id
  tags = {
    Name = "igw-${var.k8s_name}"
  }
}