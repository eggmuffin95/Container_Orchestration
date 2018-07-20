# Security Groups:

resource "aws_security_group" "ddc" {
  name        = "${var.deployment}_ddc-default"
  description = "Default Security Group for Docker EE"
  vpc_id      = "${aws_vpc.docker.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.remote_ssh_range}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_ip_range}"
  }

  # Kubernetes API
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_ip_range}"
  }

  # WinRM HTTP & HTTPS remote access - needed for Ansible
  ingress {
    from_port   = 5985
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = "${var.remote_access_range}"
  }

  ingress {
    from_port   = 5986
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = "${var.remote_access_range}"
  }

  # best to comment RDP access out after initial deployment testing!
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = "${var.remote_access_range}"
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  timeouts {
    delete = "1h"
  }
}

resource "aws_security_group" "apps" {
  name        = "${var.deployment}_apps-default"
  description = "Default Security Group for Docker EE applications"
  vpc_id      = "${aws_vpc.docker.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  timeouts {
    delete = "1h"
  }
}

resource "aws_security_group" "elb" {
  name        = "${var.deployment}_elb-default"
  description = "Default Security Group for Docker EE ELBs"
  vpc_id      = "${aws_vpc.docker.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.remote_access_range}"
  }

  # Kubernetes API
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = "${var.remote_access_range}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  timeouts {
    delete = "1h"
  }
}

resource "aws_security_group" "dtr" {
  name        = "${var.deployment}_dtr-default"
  description = "Default Security Group for Docker EE DTR ELB"
  vpc_id      = "${aws_vpc.docker.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.remote_access_range}"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.remote_access_range}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  timeouts {
    delete = "1h"
  }
}
