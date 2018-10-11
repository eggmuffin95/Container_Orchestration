resource "aws_efs_file_system" "efs" {
  creation_token = "docker-ee-efs"
  performance_mode = "maxIO"

  tags {
    Name = "docker-ee-efs"
  }
}
