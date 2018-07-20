resource "aws_placement_group" "managers" {
  name      = "managers"
  strategy  = "cluster"
}

resource "aws_autoscaling_group" "managers" {
  depends_on                = ["aws_elb.external_elb", "aws_elb.ucp_elb", "aws_elb.dtr_elb"]
  name                      = "managers-asg"
  max_size                  = "${max_autoscaled_managers_size}"
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.manager_cluster_size}"
  placement_group           = "${aws_placement_group.managers}"
  launch_configuration      = "${aws_launch_configuration.manager_asg_lc}"
  vpc_zone_identifier       = ["${aws_subnet.SubnetSwarm1}", "${aws_subnet.SubnetSwarm2}", "${aws_subnet.SubnetSwarm3}"]
  load_balancer             = ["${aws_elb.external_elb}", "${aws_elb.ucp_elb}", "${aws_elb.dtr_elb}"]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = "true"
      value               = ""
    }
  ]
}
