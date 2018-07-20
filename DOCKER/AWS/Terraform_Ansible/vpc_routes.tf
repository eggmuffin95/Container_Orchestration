resource "aws_route_table" "public_route" {
  depends_on = ["aws_internet_gateway.igw"]
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw}"
  }

  tags {
    Name = "public_route"
  }
}

resource "aws_route_table" "private_route" {
  depends_on = ["aws_nat_gateway.natgw"]
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.natgw}"
  }

  tags {
    Name = "private_route"
  }
}
