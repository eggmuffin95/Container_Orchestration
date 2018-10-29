#S3

resource "aws_s3_bucket" "dtr_storage_bucket" {
  bucket_prefix = "${var.dtr_bucket_name}"
  acl           = "private"

  tags {
    Name        = "${var.deployment}-dtr-storage"
    Environment = "${var.deployment}"
  }
}

resource "aws_s3_bucket" "access-logs_storage_bucket" {
  bucket_prefix = "${var.access_logs_bucket_name}"
  acl           = "private"

  tags {
    Name        = "${var.deployment}-access-logs-bucket"
    Environment = "${var.deployment}"
  }
}
