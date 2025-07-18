output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.bucket.id
}

output "iam_user_name" {
  description = "Name of the IAM user"
  value       = aws_iam_user.s3_user.name
}

output "iam_access_key_id" {
  description = "Access Key ID for the IAM user"
  value       = aws_iam_access_key.s3_user_key.id
  sensitive   = true
}

output "iam_secret_access_key" {
  description = "Secret Access Key for the IAM user"
  value       = aws_iam_access_key.s3_user_key.secret
  sensitive   = true
}
