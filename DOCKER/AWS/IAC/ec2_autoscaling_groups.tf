resource "aws_autoscaling_group" "asg_managers" {
  depends_on                = ["aws_elb.apps-elb", "aws_elb.ucp-elb", "aws_elb.dtr-elb"]
  name                      = "${var.deployment}-managers-asg"
  max_size                  = "${var.max_autoscaled_managers_size}"
  min_size                  = "${var.min_autoscaled_managers_size}"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.managers_cluster_size}"
  placement_group           = "${aws_placement_group.managers.id}"
  launch_configuration      = "${aws_launch_configuration.managers_asg_lc.name}"
  vpc_zone_identifier       = ["${aws_subnet.SubnetSwarm.*.id}"]
  load_balancers             = ["${aws_elb.ucp-elb.name}"]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = "true"
      value               = ""
    }
  ]
}

resource "aws_autoscaling_group" "asg_workers" {
  depends_on                = ["aws_elb.apps-elb", "aws_elb.ucp-elb", "aws_elb.dtr-elb"]
  name                      = "${var.deployment}-workers-asg"
  max_size                  = "${var.max_autoscaled_workers_size}"
  min_size                  = "${var.min_autoscaled_workers_size}"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.workers_cluster_size}"
  placement_group           = "${aws_placement_group.workers.id}"
  launch_configuration      = "${aws_launch_configuration.workers_asg_lc.name}"
  vpc_zone_identifier       = ["${aws_subnet.SubnetSwarm.*.id}"]
  load_balancers             = ["${aws_elb.apps-elb.name}"]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = "true"
      value               = ""
    }
  ]
}

resource "aws_autoscaling_group" "asg_dtr_workers" {
  count                     = "${var.dtr_workers_cluster_size}"
  depends_on                = ["aws_elb.apps-elb", "aws_elb.ucp-elb", "aws_elb.dtr-elb"]
  name                      = "${var.deployment}-dtr-workers-asg"
  max_size                  = "${var.max_autoscaled_dtr_workers_size}"
  min_size                  = "${var.min_autoscaled_dtr_workers_size}"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.dtr_workers_cluster_size}"
  placement_group           = "${aws_placement_group.dtr_workers.id}"
  launch_configuration      = "${aws_launch_configuration.dtr_workers_asg_lc.name}"
  vpc_zone_identifier       = ["${aws_subnet.SubnetSwarm.*.id}"]
  load_balancers             = ["${aws_elb.dtr-elb.name}"]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = "true"
      value               = ""
    }
  ]
}

resource "aws_autoscaling_group" "asg_windows_workers" {
  count                     = "${var.windows_workers_cluster_size}"
  depends_on                = ["aws_elb.apps-elb", "aws_elb.ucp-elb", "aws_elb.dtr-elb"]
  name                      = "${var.deployment}-windows-workers-asg"
  max_size                  = "${var.max_autoscaled_windows_workers_size}"
  min_size                  = "${var.min_autoscaled_windows_workers_size}"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.windows_workers_cluster_size}"
  placement_group           = "${aws_placement_group.windows_workers.id}"
  launch_configuration      = "${aws_launch_configuration.windows_workers_asg_lc.name}"
  vpc_zone_identifier       = ["${aws_subnet.SubnetSwarm.*.id}"]
  load_balancers             = ["${aws_elb.apps-elb.name}"]

  tags = [
    {
      key                 = "Name"
      propagate_at_launch = "true"
      value               = ""
    }
  ]
}
