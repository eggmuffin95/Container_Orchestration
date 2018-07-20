resource "aws_s3_bucket" "dtr_storage_bucket" {
  bucket_prefix = "${var.dtr_bucket_name}"
  acl           = "private"

  tags {
    Name        = "${var.deployment}-DTRStorage"
    Environment = "${var.deployment}"
  }
}
