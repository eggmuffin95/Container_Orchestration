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
