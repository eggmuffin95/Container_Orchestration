resource "aws_autoscaling_policy" "as_policy_managers" {
  name                    = "as_policy_managers"
  autoscaling_group_name  = "${aws_autoscaling_group.asg_managers}"
}

resource "aws_autoscaling_policy" "as_policy_workers" {
  name                    = "as_policy_workers"
  autoscaling_group_name  = "${aws_autoscaling_group.asg_workers}"
}

resource "aws_autoscaling_policy" "as_policy_dtr_workers" {
  name                    = "as_policy_dtr_workers"
  autoscaling_group_name  = "${aws_autoscaling_group.asg_dtr_workers}"
}

resource "aws_autoscaling_policy" "as_policy_windows_workers" {
  name                    = "as_policy_windows_workers"
  autoscaling_group_name  = "${aws_autoscaling_group.asg_windows_workers}"
}
