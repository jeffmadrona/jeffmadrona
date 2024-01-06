resource "aws_s3_bucket" "jheffx-datastore" {
  bucket = "jheffx-datastore1"

  tags = {
    Name        = "jheffx"
    Environment = "test"
  }
}

# resource "aws_s3_object" "folder" {
#   bucket = aws_s3_bucket.jheffx-datastore.id
#   key = "inbound/"
#   content_type = "application/x-directory"
# }

variable "s3_folders" {
  type        = list
  description = "The list of S3 folders to create"
  default     = ["inbound", "query_result", "system"]
}

resource "aws_s3_object" "folders" {
    count   = "${length(var.s3_folders)}"
    bucket = "${aws_s3_bucket.jheffx-datastore.id}"
    key    = "${var.s3_folders[count.index]}/"    
}

resource "aws_s3_object" "sampledata" {
  bucket = aws_s3_bucket.jheffx-datastore.id
  key = "inbound/employee"
  source = "/Users/jeffmadrona/Documents/Git Project/jeffmadrona/data/employee_sample.csv"
}

resource "aws_glue_catalog_database" "db" {
  name = "test_db"
}

resource "aws_glue_crawler" "crawler1" {
  database_name = "${aws_glue_catalog_database.db.name}"
  
  name          = "test_crawler"
  role          = "${aws_iam_role.glue-role.arn}"
  table_prefix  = "tbl_"
  
  s3_target {
    path = "s3://jheffx-datastore1/inbound/"
  }

  #schedule = "cron(0 2 * * ? *)"
}