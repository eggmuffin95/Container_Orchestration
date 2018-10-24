resource "aws_efs_file_system" "efs" {
  count = "${var.efs_supported}"
  creation_token = "docker-ee-efs"
  performance_mode = "${var.efs_performance}"

  tags {
    Name = "${format("%s-efs", "${var.deployment}")}"
  }
}
