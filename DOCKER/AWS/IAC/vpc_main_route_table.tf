resource "aws_main_route_table_association" "main_route_table" {
  depends_on      = "${aws_route_table.public_route}"
  vpc_id          = "${aws_vpc.docker.id}"
  route_table_id  = "${aws_route_table.public_route.id}"
}
