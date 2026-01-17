variable "s3_bucket_region" {
  description = "AWS region for S3 bucket"
  type        = string
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.s3_bucket_region))
    error_message = "region must be in format like 'us-east-1', 'ap-southeast-1', etc."
  }
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.s3_bucket_name))
    error_message = "it must contain only lowercase letters, numbers, and hyphens"
  }
}

variable "iam_user_name" {
  description = "Name of the IAM user"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.iam_user_name))
    error_message = "it must contain only lowercase letters, numbers, and hyphens"
  }
}
