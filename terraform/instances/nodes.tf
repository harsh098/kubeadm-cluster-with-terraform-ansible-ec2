resource "aws_instance" "master" {
  ami           = var.ami["master"] 
  instance_type = var.instance_type["master"]
  key_name      = aws_key_pair.k8s_key.key_name
  associate_public_ip_address = true
  subnet_id = var.subnet_id
  vpc_security_group_ids = [
    aws_security_group.common.id,
    aws_security_group.master.id,
    aws_security_group.flannel.id
  ]

  tags = {
    Name = "master-${var.k8s_name}"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 14
  }

  provisioner "local-exec" {
    when = create
    command = "echo 'master ${self.public_ip}' >> ${var.ansible_config_path}/hosts"
  }
}


resource "aws_instance" "workers" {
  count = var.node_count
  ami           = var.ami["worker-node"] 
  instance_type = var.instance_type["worker-node"]
  key_name      = aws_key_pair.k8s_key.key_name
  associate_public_ip_address = true
  subnet_id = var.subnet_id
  vpc_security_group_ids = [
    aws_security_group.common.id,
    aws_security_group.worker.id,
    aws_security_group.flannel.id
  ]

  tags = {
    Name = "worker-${count.index}-${var.k8s_name}"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 14
  }

  provisioner "local-exec" {
    when = create
    command = "echo 'worker-${count.index} ${self.public_ip}' >> ${var.ansible_config_path}/hosts"
  }

}

resource "null_resource" "cluster" {
  depends_on = [ aws_instance.master ]
  triggers = {
    cluster_master_node = aws_instance.master.id
    ansible_config_path = var.ansible_config_path
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm -f ${self.triggers["ansible_config_path"]}/hosts"
  }  
}