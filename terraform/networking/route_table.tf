resource "aws_route_table" "k8s_route_table" {
  vpc_id = aws_vpc.k8s-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s.id
  }
  tags = {
    Name = "route-table-${var.k8s_name}"
  }
}

resource "aws_route_table_association" "k8s_route_table_association" {
  subnet_id = aws_subnet.cluster_subnet.id
  route_table_id = aws_route_table.k8s_route_table.id
}