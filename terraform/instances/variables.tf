variable "aws_region" {
  description = "AWS Region where to deploy the K8s cluster in using EC2"
  type = string
}

variable "ami" {
  description = "Amazon machine image"
  type        = map(string)
}

variable "instance_type" {
  type = map(string)
  default = {
    master = "t2.medium"
    worker-node = "t2.micro"
  }
}

variable "ansible_config_path" {
  type = string
  description = "Path where ansible playbooks, inventory and keys will be stored"
}

variable "key_name" {
  description = "SSH Keypair for the cluster"
  type        = string
}

variable "k8s_name" {
  type        = string
  description = "cluster name"
}

variable "subnet_id" {
  description = "subnet to deploy the cluster nodes in"
}

variable "vpc_id" {
  description = "VPC where the cluster resides"
}

variable "node_count" {
  description = "# of worker nodes"
  type        = number
  default     = 2
}

variable "ansible_user_for_master_node" {
  description = "User in AMI of Master Node"
  type = string
}

variable "ansible_user_for_worker_nodes" {
  description = "User to access Worker Nodes via SSH"
  type = string
}