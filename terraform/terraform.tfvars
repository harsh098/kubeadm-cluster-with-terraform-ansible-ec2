aws_region = "us-east-1"
ansible_bucket = "hmx-ansible-bucket"
cidr_vpc = "10.0.0.0/16"
cidr_subnet = "10.0.1.0/24"
k8s_name = "cluster"
ami = {
  "master" = "ami-053b0d53c279acc90"
  "worker-node" = "ami-053b0d53c279acc90"
}
instance_type = {
  "master" = "t2.medium"
  "worker-node" = "t2.micro"
}
key_name = "cluster_ssh_keys"
ansible_user_for_master_node = "ubuntu"
ansible_user_for_worker_nodes = "ubuntu"
