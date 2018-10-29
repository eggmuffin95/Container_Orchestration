#Mount EFS

resource "aws_efs_mount_target" "mount-efs" {
  file_system_id = "${aws_efs_file_system.efs.id}"
  count           = "${var.efs_supported * length(data.aws_availability_zones.available.names)}"
  subnet_id = "${element(aws_subnet.SubnetSwarm.*.id, count.index)}"
  security_groups = ["${aws_security_group.ddc.id}"]
}
