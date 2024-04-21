resource "ansible_host" "master" {
  depends_on = [ aws_instance.master ]
  groups = [ "master" ]
  name = "master"
  variables = {
    ansible_user = var.ansible_user_for_master_node
    ansible_host = aws_instance.master.public_ip
    ansible_ssh_private_key_file = local_file.ssh_private_key.filename
    node_hostname = "master"
  }
}

resource "ansible_host" "worker" {
    depends_on = [ aws_instance.workers ]
    count = var.node_count
    name = "worker-${count.index}"
    groups = ["workers"]
    variables = {
      ansible_user = var.ansible_user_for_master_node
      ansible_host = aws_instance.workers[count.index].public_ip
      ansible_ssh_private_key_file = local_file.ssh_private_key.filename
      node_hostname = "worker-${count.index}"
    }
}


