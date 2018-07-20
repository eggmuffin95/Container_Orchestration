resource "aws_nat_gateway" "natgw" {
  depends_on = ["aws_internet_gateway.igw"]
  allocation_id = "${aws_eip.natgw}"
  subnet_id =   = "${aws_subnet.SubnetPUB}"

  tags {
    Name = "natwg"
  }
}
