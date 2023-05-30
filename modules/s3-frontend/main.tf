resource "aws_s3_bucket_public_access_block" "allow_all" {
  
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "${module.labels.id}-frontend"

  tags = module.labels.tags
}

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
  
  depends_on = [ aws_s3_bucket_public_access_block.allow_all ]
}

resource "aws_s3_bucket_object" "frontend" {
  for_each = var.files

  bucket = aws_s3_bucket.frontend_bucket.id
  key    = each.value
  source = each.value

  content_type = "text/html"
  }

resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "${var.folder_path}/index.html"
  }

}