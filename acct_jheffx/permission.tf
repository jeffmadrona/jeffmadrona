resource "aws_iam_role" "glue-role" {
  name = "jheffx-glue-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach-role" {
  role       = "${aws_iam_role.glue-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_policy" "jheffx-s3" {
  name        = "jheffx-s3policy"
  description = "Add access to jheffx s3 to glue"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::jheffx-datastore1/*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach-s3policy-role" {
  role       = "${aws_iam_role.glue-role.name}"
  policy_arn = aws_iam_policy.jheffx-s3.arn
}