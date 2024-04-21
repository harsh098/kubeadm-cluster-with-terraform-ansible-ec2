variable "aws_region" {
  description = "AWS Region where to deploy the K8s cluster in using EC2"
  type = string
}

variable "cidr_vpc" {
  description = "cidr range for VPC"
  type        = string
}

variable "cidr_subnet" {
  description = "cidr range for public VPC Subnet"
  type        = string
}

variable "k8s_name" {
  type        = string
  description = "cluster"

}