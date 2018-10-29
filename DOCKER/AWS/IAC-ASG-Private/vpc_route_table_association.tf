#Route Tables Associations

resource "aws_route_table_association" "rta_priv_subnetswarm" {
  count          = "${length("${data.aws_availability_zones.available.names}")}"
  subnet_id       = "${element(aws_subnet.SubnetSwarm.*.id, count.index)}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetexternal" {
  count          = "${length("${data.aws_availability_zones.available.names}")}"
  subnet_id       = "${element(aws_subnet.SubnetExternal.*.id, count.index)}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetucp" {
  count          = "${length("${data.aws_availability_zones.available.names}")}"
  subnet_id       = "${element(aws_subnet.SubnetUCP.*.id, count.index)}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetdtr" {
  count          = "${length("${data.aws_availability_zones.available.names}")}"
  subnet_id       = "${element(aws_subnet.SubnetDTR.*.id, count.index)}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_pub_subnetpub" {
  subnet_id       = "${aws_subnet.SubnetPUB.id}"
  route_table_id  = "${aws_route_table.public_route.id}"
}
