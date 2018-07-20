resource "aws_s3_bucket" "DTR Storage Endpoint" {
  bucket = "${var.dtr_bucket_name}"
  acl    = "private"

  tags {
    Name        = "DTR Bucket"
  }
}
