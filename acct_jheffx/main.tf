resource "aws_s3_bucket" "jheffx-datastore" {
  bucket = "jheffx-datastore1"

  tags = {
    Name        = "jheffx"
    Environment = "test"
  }
}

resource "aws_s3_object" "folder" {
  bucket = aws_s3_bucket.jheffx-datastore.id
  key = "inbound/"
  content_type = "application/x-directory"
}

resource "aws_s3_object" "sampledata" {
  bucket = aws_s3_bucket.jheffx-datastore.id
  key = "inbound/employee"
  source = "/Users/jeffmadrona/Documents/Git Project/jeffmadrona/data/employee_sample.csv"
}