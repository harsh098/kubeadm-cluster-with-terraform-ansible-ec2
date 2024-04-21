resource "aws_security_group" "common" {
  vpc_id = var.vpc_id
  name = "well-known-ports-sg"
  tags = {
    Name = "well-known-ports-sg"
  }
  ingress {
    description = "Allow HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  ingress {
    description = "Allow HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  ingress {
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  egress {
    description = "Allow HTTP"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "master" {
  vpc_id = var.vpc_id
  name = "controlplane-sg"
  tags = {
    Name = "controlplane-sg"
  }

  ingress {
    description = "Kube API Server"
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  ingress {
    description = "etcd Server Client API"
    protocol = "tcp"
    from_port = 2379
    to_port = 2380
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  ingress {
    description = "Kubelet API"
    protocol = "tcp"
    from_port = 10250
    to_port = 10250
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  ingress {
    description = "kube-scheduler"
    protocol = "tcp"
    from_port = 10259
    to_port = 10259
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  ingress {
    description = "kube-controller-manager"
    protocol = "tcp"
    from_port = 10257
    to_port = 10257
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }
    
}

resource "aws_security_group" "flannel" {
  vpc_id = var.vpc_id
  name = "flannel-cni-network-overlay-sg"
  tags = {
    Name = "flannel-cni-network-overlay-sg"
  }
  ingress {
    description = "Flannel VXLAN Overlay"
    protocol = "udp"
    from_port = 8285
    to_port = 8285
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  ingress {
    description = "Flannel UDP Backend"
    protocol = "udp"
    from_port = 8472
    to_port = 8472
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }
  
}

resource "aws_security_group" "worker" {
  vpc_id = var.vpc_id
  name = "workernodes-sg"
  tags = {
    Name = "workernodes-sg"
  }

  ingress {
    description = "Kubelet API"
    protocol = "tcp"
    from_port = 10250
    to_port = 10250
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  ingress {
    description = "kube-proxy"
    protocol = "tcp"
    from_port = 10256
    to_port = 10256
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

  ingress {
    description = "NodePort"
    protocol = "tcp"
    from_port = 30000
    to_port = 32767
    cidr_blocks = [
        "0.0.0.0/0"
    ]
  }

}