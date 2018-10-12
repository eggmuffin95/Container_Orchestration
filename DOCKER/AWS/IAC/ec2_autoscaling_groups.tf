resource "aws_autoscaling_group" "asg_managers" {
  depends_on                = ["aws_elb.external_elb", "aws_elb.ucp_elb", "aws_elb.dtr_elb"]
  name                      = "managers-asg"
  max_size                  = "${max_autoscaled_managers_size}"
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.managers_cluster_size}"
  placement_group           = "${aws_placement_group.managers.id}"
  launch_configuration      = "${aws_launch_configuration.managers_asg_lc}"
  vpc_zone_identifier       = ["${aws_subnet.SubnetSwarm1}", "${aws_subnet.SubnetSwarm2}", "${aws_subnet.SubnetSwarm3}"]
  load_balancer             = ["${aws_elb.ucp_elb}"]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = "true"
      value               = ""
    }
  ]
}

resource "aws_autoscaling_group" "asg_workers" {
  depends_on                = ["aws_elb.external_elb", "aws_elb.ucp_elb", "aws_elb.dtr_elb"]
  name                      = "workers-asg"
  max_size                  = "${max_autoscaled_workers_size}"
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.workers_cluster_size}"
  placement_group           = "${aws_placement_group.workers.id}"
  launch_configuration      = "${aws_launch_configuration.workers_asg_lc}"
  vpc_zone_identifier       = ["${aws_subnet.SubnetSwarm1}", "${aws_subnet.SubnetSwarm2}", "${aws_subnet.SubnetSwarm3}"]
  load_balancer             = ["${aws_elb.external_elb}"]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = "true"
      value               = ""
    }
  ]
}

resource "aws_autoscaling_group" "asg_dtr_workers" {
  depends_on                = ["aws_elb.external_elb", "aws_elb.ucp_elb", "aws_elb.dtr_elb"]
  name                      = "dtr-workers-asg"
  max_size                  = "${max_autoscaled_dtr_workers_size}"
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.dtr_workers_cluster_size}"
  placement_group           = "${aws_placement_group.dtr_workers.id}"
  launch_configuration      = "${aws_launch_configuration.dtr_workers_asg_lc}"
  vpc_zone_identifier       = ["${aws_subnet.SubnetSwarm1}", "${aws_subnet.SubnetSwarm2}", "${aws_subnet.SubnetSwarm3}"]
  load_balancer             = ["${aws_elb.dtr_elb}"]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = "true"
      value               = ""
    }
  ]
}

resource "aws_autoscaling_group" "asg_windows_workers" {
  depends_on                = ["aws_elb.external_elb", "aws_elb.ucp_elb", "aws_elb.dtr_elb"]
  name                      = "windows-workers-asg"
  max_size                  = "${max_autoscaled_windows_workers_size}"
  min_size                  = 0
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.windows_workers_cluster_size}"
  placement_group           = "${aws_placement_group.windows_workers.id}"
  launch_configuration      = "${aws_launch_configuration.windows_workers_asg_lc}"
  vpc_zone_identifier       = ["${aws_subnet.SubnetSwarm1}", "${aws_subnet.SubnetSwarm2}", "${aws_subnet.SubnetSwarm3}"]
  load_balancer             = ["${aws_elb.external_elb}"]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = "true"
      value               = ""
    }
  ]
}
