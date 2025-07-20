variable "ses_user_name" {
  description = "The name of the IAM user to send emails via AWS SES"
  type        = string
}

variable "dns_record_prefix" {
  description = "The DNS record prefix"
  type        = string
}

variable "cloudflare_zone" {
  description = "Zone ID for your domain"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Zone ID for your domain"
  type        = string
}
