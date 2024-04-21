variable "aws_region" {
  description = "AWS Region where to deploy the K8s cluster in using EC2"
  type        = string
  default = "us-east-1"
}

variable "ansible_bucket" {
  description = "S3 Bucket where ansible inventory will be stored"
  type        = string
}


variable "cidr_vpc" {
  description = "cidr range for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr_subnet" {
  description = "cidr range for public VPC Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "k8s_name" {
  type        = string
  description = "cluster"
  default     = "kubeadm-cluster"
}

variable "ami" {
  description = "amazon machine image"
  type        = map(string)
}

variable "instance_type" {
  type = map(string)
  default = {
    master      = "t2.medium"
    worker-node = "t2.micro"
  }
}

variable "key_name" {
  description = "keypair for the cluster"
  type        = string
  default     = "k8s-cluster"
}

variable "node_count" {
  description = "# of worker nodes"
  type        = number
  default     = 2
}

variable "github_workspace" {
  description = "The GitHub workspace directory"
  type        = string
  default     = "{{ github.workspace }}"
}

variable "ansible_user_for_master_node" {
  description = "User to access Master Nodes via SSH"
  type = string
  default = "ubuntu"
}

variable "ansible_user_for_worker_nodes" {
  description = "User to access Worker Nodes via SSH"
  type = string
  default = "ubuntu"  
}
