resource "aws_subnet" "SubnetSwarm1" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.10.0/24"

  tags {
    Name = "SubnetSwarm1"
  }
}

resource "aws_subnet" "SubnetSwarm2" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.11.0/24"

  tags {
    Name = "SubnetSwarm2"
  }
}

resource "aws_subnet" "SubnetSwarm3" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.12.0/24"

  tags {
    Name = "SubnetSwarm3"
  }
}

resource "aws_subnet" "SubnetExternal1" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.13.0/24"

  tags {
    Name = "SubnetExternal1"
  }
}

resource "aws_subnet" "SubnetExternal2" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.14.0/24"

  tags {
    Name = "SubnetExternal2"
  }
}

resource "aws_subnet" "SubnetExternal3" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.15.0/24"

  tags {
    Name = "SubnetExternal3"
  }
}

resource "aws_subnet" "SubnetUCP1" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.16.0/24"

  tags {
    Name = "SubnetUCP1"
  }
}

resource "aws_subnet" "SubnetUCP2" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.17.0/24"

  tags {
    Name = "SubnetUCP2"
  }
}

resource "aws_subnet" "SubnetUCP3" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.18.0/24"

  tags {
    Name = "SubnetUCP3"
  }
}

resource "aws_subnet" "SubnetDTR1" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.19.0/24"

  tags {
    Name = "SubnetDTR1"
  }
}

resource "aws_subnet" "SubnetDTR2" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.20.0/24"

  tags {
    Name = "SubnetDTR2"
  }
}

resource "aws_subnet" "SubnetDTR3" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.21.0/24"

  tags {
    Name = "SubnetDTR3"
  }
}

resource "aws_subnet" "SubnetPUB" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "172.30.22.0/24"

  tags {
    Name = "SubnetPUB"
  }
}
