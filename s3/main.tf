provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key

}

resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "my-frontend-terraform-bucket-web-hosting"

}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false


}

resource "aws_s3_bucket_website_configuration" "web-config" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.frontend_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.frontend_bucket.id
  key          = "index.html"
  source       = "D:/terraform major project/Application/frontend/index.html"
  content_type = "text/html"

  depends_on = [aws_s3_bucket_policy.public_policy, aws_s3_bucket_public_access_block.public_access]
}

resource "aws_s3_object" "js" {
  bucket       = aws_s3_bucket.frontend_bucket.id
  key          = "script.js"
  source       = "D:/terraform major project/Application/frontend/script.js"
  content_type = "application/javascript"
  depends_on   = [aws_s3_bucket_policy.public_policy, aws_s3_bucket_public_access_block.public_access]

}
