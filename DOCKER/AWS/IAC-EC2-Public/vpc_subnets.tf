#Subnets

resource "aws_subnet" "SubnetSwarm" {
  vpc_id = "${aws_vpc.docker.id}"
  count  = "${length("${data.aws_availability_zones.available.names}")}"

  cidr_block              = "${cidrsubnet("${var.swarm_cidr}", 2, count.index)}"
  map_public_ip_on_launch = "${var.scheme_subnets}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"

  tags = {
    Name = "${format("%s-SubnetSwarm-%d", "${var.deployment}", count.index + 1)}"
  }
}

resource "aws_subnet" "SubnetExternal" {
  vpc_id = "${aws_vpc.docker.id}"
  count  = "${length("${data.aws_availability_zones.available.names}")}"

  cidr_block              = "${cidrsubnet("${var.ext_cidr}", 2, count.index)}"
  map_public_ip_on_launch = "${var.scheme_subnets}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"

  tags = {
    Name = "${format("%s-SubnetExternal-%d", "${var.deployment}", count.index + 1)}"
  }
}

resource "aws_subnet" "SubnetUCP" {
  vpc_id = "${aws_vpc.docker.id}"
  count  = "${length("${data.aws_availability_zones.available.names}")}"

  cidr_block              = "${cidrsubnet("${var.ucp_cidr}", 2, count.index)}"
  map_public_ip_on_launch = "${var.scheme_subnets}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"

  tags = {
    Name = "${format("%s-SubnetUCP-%d", "${var.deployment}", count.index + 1)}"
  }
}

resource "aws_subnet" "SubnetDTR" {
  vpc_id = "${aws_vpc.docker.id}"
  count  = "${length("${data.aws_availability_zones.available.names}")}"

  cidr_block              = "${cidrsubnet("${var.dtr_cidr}", 2, count.index)}"
  map_public_ip_on_launch = "${var.scheme_subnets}"
  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"

  tags = {
    Name = "${format("%s-SubnetDTR-%d", "${var.deployment}", count.index + 1)}"
  }
}
