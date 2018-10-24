resource "aws_autoscaling_policy" "as_policy_managers" {
  name                    = "as_policy_managers"
  scaling_adjustment      = 1
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  autoscaling_group_name  = "${aws_autoscaling_group.asg_managers.name}"
}

resource "aws_autoscaling_policy" "as_policy_workers" {
  name                    = "as_policy_workers"
  scaling_adjustment      = 1
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  autoscaling_group_name  = "${aws_autoscaling_group.asg_workers.name}"
}

resource "aws_autoscaling_policy" "as_policy_dtr_workers" {
  count                   = "${var.dtr_workers_cluster_size}"
  name                    = "as_policy_dtr_workers"
  scaling_adjustment      = 1
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  autoscaling_group_name  = "${aws_autoscaling_group.asg_dtr_workers.name}"
}

resource "aws_autoscaling_policy" "as_policy_windows_workers" {
  count                   = "${var.windows_workers_cluster_size}"
  name                    = "as_policy_windows_workers"
  scaling_adjustment      = 1
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  autoscaling_group_name  = "${aws_autoscaling_group.asg_windows_workers.name}"
}
