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

}