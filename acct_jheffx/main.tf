resource "aws_s3_bucket" "jheffx-datastore" {
  bucket = "jheffx-datastore1"

  tags = {
    Name        = "jheffx"
    Environment = "test"
  }
}