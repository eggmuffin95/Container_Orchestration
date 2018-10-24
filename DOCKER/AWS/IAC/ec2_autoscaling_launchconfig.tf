resource "aws_launch_configuration" "managers_asg_lc" {
  name = "${var.deployment}-managers-launchconfig"
  image_id = "${var.ami}"
  instance_type = "${var.linux_manager_instance_type}"
  key_name = "${var.deployment}-manager-instance"

  associate_public_ip_address = "${var.scheme_ec2}"

  iam_instance_profile = "${aws_iam_instance_profile.dtr_instance_profile.id}"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.ddc.id}"]
  ebs_optimized = "${var.ebs_optimized}"
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.linux_manager_volume_system_size}"
    delete_on_termination = "${var.delete_root_ebs}"
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_type = "gp2"
    volume_size = "${var.linux_manager_volume_data_size}"
    delete_on_termination = "${var.delete_data_ebs}"
  }
  user_data = "${file("${var.bootstrap_path}")}"

}

resource "aws_launch_configuration" "workers_asg_lc" {
  name = "${var.deployment}-workers-launchconfig"
  image_id = "${var.ami}"
  instance_type = "${var.linux_worker_instance_type}"
  key_name = "${var.deployment}-worker-instance"

  associate_public_ip_address = "${var.scheme_ec2}"

  iam_instance_profile = "${aws_iam_instance_profile.dtr_instance_profile.id}"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.ddc.id}"]
  ebs_optimized = "${var.ebs_optimized}"
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.linux_worker_volume_system_size}"
    delete_on_termination = "${var.delete_root_ebs}"
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_type = "gp2"
    volume_size = "${var.linux_worker_volume_data_size}"
    delete_on_termination = "${var.delete_data_ebs}"
  }
  user_data = "${file("${var.bootstrap_path}")}"
}

resource "aws_launch_configuration" "dtr_workers_asg_lc" {
  count = "${var.dtr_workers_cluster_size}"
  name = "${var.deployment}-dtr-workers-launchconfig"
  image_id = "${var.ami}"
  instance_type = "${var.linux_dtr_worker_instance_type}"
  key_name = "${var.deployment}-dtr-worker-instance"

  associate_public_ip_address = "${var.scheme_ec2}"

  iam_instance_profile = "${aws_iam_instance_profile.dtr_instance_profile.id}"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.ddc.id}"]
  ebs_optimized = "${var.ebs_optimized}"
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.linux_dtr_worker_volume_system_size}"
    delete_on_termination = "${var.delete_root_ebs}"
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_type = "gp2"
    volume_size = "${var.linux_dtr_worker_volume_data_size}"
    delete_on_termination = "${var.delete_data_ebs}"
  }
  user_data = "${file("${var.bootstrap_path}")}"
}

resource "aws_launch_configuration" "windows_workers_asg_lc" {
  count = "${var.windows_workers_cluster_size}"
  name = "${var.deployment}-windows-workers-launchconfig"
  image_id = "${var.ami}"
  instance_type = "${var.windows_worker_instance_type}"
  key_name = "${var.deployment}-windows-worker-instance"

  associate_public_ip_address = "${var.scheme_ec2}"

  iam_instance_profile = "${aws_iam_instance_profile.dtr_instance_profile.id}"
  key_name = "${var.key_name}"
  security_groups = ["${aws_security_group.ddc.id}"]
  ebs_optimized = "${var.ebs_optimized}"
  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.windows_worker_volume_system_size}"
    delete_on_termination = "${var.delete_root_ebs}"
  }
  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_type = "gp2"
    volume_size = "${var.windows_worker_volume_data_size}"
    delete_on_termination = "${var.delete_data_ebs}"
  }
  user_data = "${file("${var.bootstrap_path}")}"
}
