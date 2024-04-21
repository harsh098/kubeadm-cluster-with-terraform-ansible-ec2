output "subnet_id" {
  value = aws_subnet.cluster_subnet.id 
}

output "vpc_id" {
  value = aws_vpc.k8s-vpc.id
}

