resource "aws_eip" "natgw" {
  vpc         = true
  depends_on  = ["aws_internet_gateway.igw"]
  tags {
    Name = natgweip
  }
}
