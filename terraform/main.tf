terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    ansible = {
      source = "ansible/ansible"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
  backend "s3" {
    bucket = "hmx-terraform-bucket"
    key    = "terraform_state/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}


module "instances" {
  depends_on = [ module.networking ]
  source     = "./instances"
  aws_region = var.aws_region
  ami = {
    master      = var.ami["master"]
    worker-node = var.ami["worker-node"]
  }
  instance_type = {
    master      = var.instance_type["master"]
    worker-node = var.instance_type["worker-node"]
  }
  ansible_config_path = abspath("${path.module}/../ansible")
  key_name            = var.key_name
  k8s_name            = var.k8s_name
  subnet_id           = module.networking.subnet_id
  vpc_id = module.networking.vpc_id
  node_count = var.node_count
  ansible_user_for_master_node = var.ansible_user_for_master_node
  ansible_user_for_worker_nodes = var.ansible_user_for_worker_nodes
}

module "networking" {
  source      = "./networking"
  aws_region  = var.aws_region
  cidr_subnet = var.cidr_subnet
  cidr_vpc    = var.cidr_vpc
  k8s_name    = var.k8s_name
}

# TODO Add ASG to this configuration
# module "asg" {
#   source     = "./node_asg"
#   aws_region = var.aws_region
#   node_count = var.node_count
# }
