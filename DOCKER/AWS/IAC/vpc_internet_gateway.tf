resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.docker.id}"

  tags {
    Name = "${format("%s-igw", "${var.deployment}")}"
  }
}
