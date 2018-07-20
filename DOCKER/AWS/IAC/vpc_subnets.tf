resource "aws_subnet" "SubnetSwarm1" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.10.0/24"

  tags {
    Name = "SubnetSwarm1"
  }
}

resource "aws_subnet" "SubnetSwarm2" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.11.0/24"

  tags {
    Name = "SubnetSwarm2"
  }
}

resource "aws_subnet" "SubnetSwarm3" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.12.0/24"

  tags {
    Name = "SubnetSwarm3"
  }
}

resource "aws_subnet" "SubnetExternal1" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.13.0/24"

  tags {
    Name = "${format("%s-SubnetExternal1", "${var.deployment}")}"
  }
}

resource "aws_subnet" "SubnetExternal2" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.14.0/24"

  tags {
    Name = "${format("%s-SubnetExternal2", "${var.deployment}")}"
  }
}

resource "aws_subnet" "SubnetExternal3" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.15.0/24"

  tags {
    Name = "${format("%s-SubnetExternal3", "${var.deployment}")}"
  }
}

resource "aws_subnet" "SubnetUCP1" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.16.0/24"

  tags {
    Name = "${format("%s-SubnetUCP1", "${var.deployment}")}"
  }
}

resource "aws_subnet" "SubnetUCP2" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.17.0/24"

  tags {
    Name = "${format("%s-SubnetUCP2", "${var.deployment}")}"
  }
}

resource "aws_subnet" "SubnetUCP3" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.18.0/24"

  tags {
    Name = "${format("%s-SubnetUCP3", "${var.deployment}")}"
  }
}

resource "aws_subnet" "SubnetDTR1" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.19.0/24"

  tags {
    Name = "${format("%s-SubnetDTR1", "${var.deployment}")}"
  }
}

resource "aws_subnet" "SubnetDTR2" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.20.0/24"

  tags {
    Name = "${format("%s-SubnetDTR2", "${var.deployment}")}"
  }
}

resource "aws_subnet" "SubnetDTR3" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.21.0/24"

  tags {
    Name = "${format("%s-SubnetDTR3", "${var.deployment}")}"
  }
}

resource "aws_subnet" "SubnetPUB" {
  vpc_id     = "${aws_vpc.docker.id}"
  cidr_block = "172.30.22.0/24"

  tags {
    Name = "${format("%s-SubnetPUB", "${var.deployment}")}"
  }
}
