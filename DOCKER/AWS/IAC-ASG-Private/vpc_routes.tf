#Routes

resource "aws_route_table" "public_route" {
  depends_on = ["aws_internet_gateway.igw"]
  vpc_id = "${aws_vpc.docker.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${format("%s-pub-route", "${var.deployment}")}"
  }
}

resource "aws_route_table" "private_route" {
  depends_on = ["aws_nat_gateway.natgw"]
  vpc_id = "${aws_vpc.docker.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.natgw.id}"
  }

  tags {
    Name = "${format("%s-priv-route", "${var.deployment}")}"
  }
}
