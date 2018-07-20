resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.docker.id}"

  tags {
    Name = "igw"
  }
}
