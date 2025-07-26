output "ses_access_key_id" {
  value     = aws_iam_access_key.ses_user_key.id
  sensitive = true
}

output "ses_smtp_password_v4" {
  value = aws_iam_access_key.ses_user_key.ses_smtp_password_v4
}

output "smtp_endpoint" {
  value = "email-smtp.${aws_ses_domain_identity.default.region}.amazonaws.com"
}

output "smtp_domain" {
  value = aws_ses_domain_identity.default.domain
}
