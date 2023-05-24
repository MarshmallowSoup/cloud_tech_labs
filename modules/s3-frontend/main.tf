resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id

  policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
            "s3:GetObject"
          ],
          "Resource": [
            "arn:aws:s3:::${aws_s3_bucket.frontend_bucket.id}/*"
          ]
        }
      ]
    }
    EOF
}

resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "${module.labels.id}-frontend"

  tags = module.labels.tags
}

resource "aws_s3_object" "frontend" {
  bucket = aws_s3_bucket.frontend_bucket.id
  key    = var.object_name
  source = var.path_to_file
}

resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "index.html"
  }

}