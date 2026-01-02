terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }
}

# S3 Bucket.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
  region = var.s3_bucket_region
}

# Block public access for the S3 bucket.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

# S3 lifetime policy.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration
resource "aws_s3_bucket_lifecycle_configuration" "default" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    id     = "glacier-deep-archive_expire-after-180-days"
    status = "Enabled"
    filter {}
    # Transition to DEEP_ARCHIVE after 1 day
    transition {
      days          = 1
      storage_class = "DEEP_ARCHIVE"
    }
    # Expire (delete) objects after 180 days.
    expiration {
      days = 180
    }
  }
}

# IAM User.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "s3_user" {
  name = var.iam_user_name
}

# IAM Policy for S3 Write Access.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "s3_write_policy" {
  name        = "S3Write-${var.s3_bucket_name}"
  description = "Policy to allow write access to the specified S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      }
    ]
  })
}

# Attach Policy to IAM User.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment
resource "aws_iam_user_policy_attachment" "s3_user_policy_attachment" {
  user       = aws_iam_user.s3_user.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}

# Create Access Key for the IAM User.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key
resource "aws_iam_access_key" "s3_user_key" {
  user = aws_iam_user.s3_user.name
}
