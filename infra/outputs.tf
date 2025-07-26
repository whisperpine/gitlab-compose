# --------------------
# module: cloudflare_tunnel
# --------------------

output "tunnel_token" {
  description = "Cloudflare Tunnel token, which should be assigned to CLOUDFLARED_TOKEN in .env"
  value       = module.cloudflare_tunnel.tunnel_token
  sensitive   = true
}

# --------------------
# module: aws_s3
# --------------------

output "s3_bucket_name" {
  description = "It should be assigned to BACKUP_UPLOAD_REMOTE_DIRECTORY in .env"
  value       = module.aws_s3.s3_bucket_name
  sensitive   = true
}

output "s3_access_key_id" {
  description = "It should be assigned to BACKUP_AWS_ACCESS_KEY_ID in .env"
  value       = module.aws_s3.s3_access_key_id
  sensitive   = true
}

output "s3_secret_access_key" {
  description = "It should be assigned to BACKUP_AWS_SECRET_ACCESS_KEY in .env"
  value       = module.aws_s3.s3_secret_access_key
  sensitive   = true
}

# --------------------
# module: aws_ses
# --------------------

output "ses_access_key_id" {
  description = "It should be assigned to SMTP_USER_NAME in .env"
  value       = module.aws_ses.ses_access_key_id
  sensitive   = true
}

output "ses_smtp_password_v4" {
  description = "It should be assigned to SMTP_PASSWORD in .env"
  value       = module.aws_ses.ses_smtp_password_v4
  sensitive   = true
}

output "smtp_endpoint" {
  description = "It should be assigned to SMTP_ADDRESS in .env"
  value       = module.aws_ses.smtp_endpoint
}

output "smtp_domain" {
  description = "It should be assigned to SMTP_DOMAIN in .env"
  value       = module.aws_ses.smtp_domain
  sensitive   = true
}
