#Route Tables Associations

resource "aws_route_table_association" "rta_pub_subnetswarm" {
  count          = "${length("${data.aws_availability_zones.available.names}")}"
  subnet_id       = "${element(aws_subnet.SubnetSwarm.*.id, count.index)}"
  route_table_id  = "${aws_route_table.public_route.id}"
}

resource "aws_route_table_association" "rta_public_subnetexternal" {
  count          = "${length("${data.aws_availability_zones.available.names}")}"
  subnet_id       = "${element(aws_subnet.SubnetExternal.*.id, count.index)}"
  route_table_id  = "${aws_route_table.public_route.id}"
}

resource "aws_route_table_association" "rta_public_subnetucp" {
  count          = "${length("${data.aws_availability_zones.available.names}")}"
  subnet_id       = "${element(aws_subnet.SubnetUCP.*.id, count.index)}"
  route_table_id  = "${aws_route_table.public_route.id}"
}

resource "aws_route_table_association" "rta_public_subnetdtr" {
  count          = "${length("${data.aws_availability_zones.available.names}")}"
  subnet_id       = "${element(aws_subnet.SubnetDTR.*.id, count.index)}"
  route_table_id  = "${aws_route_table.public_route.id}"
}
