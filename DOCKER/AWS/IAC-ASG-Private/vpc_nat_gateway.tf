#NAT Gateway

resource "aws_nat_gateway" "natgw" {
  depends_on = ["aws_internet_gateway.igw"]
  allocation_id = "${aws_eip.natgw.id}"
  subnet_id = "${aws_subnet.SubnetPUB.id}"

  tags {
    Name = "${format("%s-natgw", "${var.deployment}")}"
  }
}
