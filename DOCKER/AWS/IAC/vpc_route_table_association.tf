resource "aws_route_table_association" "rta_priv_subnetswarm1" {
  subnet_id       = "${aws_subnet.SubnetSwarm1.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetswarm2" {
  subnet_id       = "${aws_subnet.SubnetSwarm2.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetswarm3" {
  subnet_id       = "${aws_subnet.SubnetSwarm3.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetexternal1" {
  subnet_id       = "${aws_subnet.SubnetExternal1.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetexternal2" {
  subnet_id       = "${aws_subnet.SubnetExternal2.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetexternal3" {
  subnet_id       = "${aws_subnet.SubnetExternal3.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetucp1" {
  subnet_id       = "${aws_subnet.SubnetUCP1.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetucp2" {
  subnet_id       = "${aws_subnet.SubnetUCP2.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetucp3" {
  subnet_id       = "${aws_subnet.SubnetUCP3.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetdtr1" {
  subnet_id       = "${aws_subnet.SubnetDTR1.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetdtr2" {
  subnet_id       = "${aws_subnet.SubnetDTR2.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_priv_subnetdtr3" {
  subnet_id       = "${aws_subnet.SubnetDTR3.id}"
  route_table_id  = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "rta_pub_subnetpub" {
  subnet_id       = "${aws_subnet.SubnetPUB.id}"
  route_table_id  = "${aws_route_table.public_route.id}"
}
