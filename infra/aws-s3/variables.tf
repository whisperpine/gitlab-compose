variable "s3_bucket_region" {
  description = "AWS region for S3 bucket"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "iam_user_name" {
  description = "Name of the IAM user"
  type        = string
}
