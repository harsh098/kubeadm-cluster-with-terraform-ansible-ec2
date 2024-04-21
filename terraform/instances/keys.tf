resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "k8s_key" {
  key_name = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "ssh_private_key" {
  filename = abspath("${var.ansible_config_path}/keys/id_rsa")
  content  = tls_private_key.ssh_key.private_key_openssh
  provisioner "local-exec" {
    command = "chmod 400 ${abspath("${var.ansible_config_path}/keys/id_rsa")}"
  }
}

