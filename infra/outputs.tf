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

output "iam_access_key_id" {
  description = "It should be assigned to BACKUP_AWS_ACCESS_KEY_ID in .env"
  value       = module.aws_s3.iam_access_key_id
  sensitive   = true
}

output "iam_secret_access_key" {
  description = "It should be assigned to BACKUP_AWS_SECRET_ACCESS_KEY in .env"
  value       = module.aws_s3.iam_secret_access_key
  sensitive   = true
}
