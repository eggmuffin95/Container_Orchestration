#ELBs

resource "aws_elb" "ucp-elb" {
  name = "${var.deployment}-ucp-elb"

  security_groups = ["${aws_security_group.elb.id}"]

  subnets = ["${aws_subnet.SubnetUCP.*.id}"]

  internal = "${var.scheme_elb}"

  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 6443
    instance_protocol = "tcp"
    lb_port           = 6443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 5
    target              = "TCP:443"
    interval            = 30
  }

  idle_timeout              = 240
  cross_zone_load_balancing = true
  depends_on                = ["aws_internet_gateway.igw"]
}

output "UCPDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${aws_elb.ucp-elb.dns_name}"
}

resource "aws_elb" "apps-elb" {
  name = "${var.deployment}-apps-elb"

  security_groups = ["${aws_security_group.apps.id}"]

  subnets = ["${aws_subnet.SubnetExternal.*.id}"]

  internal = "${var.scheme_elb}"

  listener {
    instance_port     = 8443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 8000
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 5
    target              = "TCP:8443"
    interval            = 30
  }

  cross_zone_load_balancing = true
  depends_on                = ["aws_internet_gateway.igw"]
}

output "AppDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${aws_elb.apps-elb.dns_name}"
}

resource "aws_elb" "dtr-elb" {
  name = "${var.deployment}-dtr-elb"

  security_groups = ["${aws_security_group.dtr.id}"]

  subnets = ["${aws_subnet.SubnetDTR.*.id}"]

  internal = "${var.scheme_elb}"

  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 5
    target              = "TCP:443"
    interval            = 30
  }

  idle_timeout              = 240
  cross_zone_load_balancing = true
  depends_on                = ["aws_internet_gateway.igw"]
}

output "DTRDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${aws_elb.dtr-elb.dns_name}"
}
