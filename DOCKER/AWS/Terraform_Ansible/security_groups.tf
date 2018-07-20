resource "aws_security_group" "UCPLoadBalancerSG" {
  name = "ucploadbalancersg"
  vpc_id = "${var.vpc_id}"

  # Allow HTTPS Inbound Traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.remote_access_range}"
  }
}

resource "aws_security_group" "DTRLoadBalancerSG" {
  name = "dtrloadbalancersg"
  vpc_id = "${var.vpc_id}"

  # Allow HTTPS Inbound Traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.remote_access_range}"
  }
}

resource "aws_security_group" "ExternalLoadBalancerSG" {
  name = "externalloadbalancersg"
  vpc_id = "${var.vpc_id}"

  # Allow All Inbound Traffic
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = "${var.remote_access_range}"
  }
}

resource "aws_security_group" "ManagerVpcSG" {
  name = "managervpcsg"
  vpc_id = "${var.vpc_id}"

  # Allow Manager Inbound and Outbound Traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.remote_ssh_range}"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "50"
    cidr_blocks = "${var.vpc_ip_range}"
  }
  ingress {
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_ip_range}"
  }
  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = "${var.vpc_ip_range}"
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_ip_range}"
  }
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = "${var.vpc_ip_range}"
  }
}

resource "aws_security_group" "NodeVpcSG" {
  name = "nodevpcsg"
  vpc_id = "${var.vpc_id}"

  # Allow Nodes Traffic
  egress = {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "50"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress = {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress = {
    from_port   = 0
    to_port     = 2374
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress = {
    from_port   = 2376
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress = {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = "${var.vpc_ip_range}"
  }
}

resource "aws_security_group" "SwarmWideVPC" {
  name    = "swarmwidevpc"
  vpc_id  = "${var.vpc_id}"

  # Swarm Wide Access
  ingress = {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = "${var.vpc_ip_range}"
  }
}
