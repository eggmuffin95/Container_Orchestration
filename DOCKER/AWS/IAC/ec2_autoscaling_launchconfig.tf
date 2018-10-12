resource "aws_launch_configuration" "managers_asg_lc" {
  name = "managers-launchconfig"
  image_id = "${ami}"
  instance_type = "${linux_manager_instance_type}"
}

resource "aws_launch_configuration" "workers_asg_lc" {
  name = "workers-launchconfig"
  image_id = "${ami}"
  instance_type = "${linux_worker_instance_type}"
}

resource "aws_launch_configuration" "dtr_workers_asg_lc" {
  name = "dtr-workers-launchconfig"
  image_id = "${ami}"
  instance_type = "${linux_dtr_worker_instance_type}"
}

resource "aws_launch_configuration" "windows_workers_asg_lc" {
  name = "windows-workers-launchconfig"
  image_id = "${ami}"
  instance_type = "${windows_worker_instance_type}"
}
