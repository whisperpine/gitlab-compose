terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.15.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.12.0"
    }
  }
}

# --------------------
# AWS SES
# --------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity
resource "aws_ses_domain_identity" "default" {
  domain = "${var.dns_record_prefix}.${var.cloudflare_zone}"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim
resource "aws_ses_domain_dkim" "default" {
  domain = aws_ses_domain_identity.default.domain
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity_verification
resource "aws_ses_domain_identity_verification" "default" {
  domain = aws_ses_domain_identity.default.domain
}

# --------------------
# AWS IAM user
# --------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "ses_user" {
  name = var.ses_user_name
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "ses_send_policy" {
  name        = "SES-${aws_ses_domain_identity.default.domain}"
  description = "Policy to sending emails via AWS SES"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ses:SendEmail", "ses:SendRawEmail"]
        Resource = [aws_ses_domain_identity.default.arn]
      }
    ]
  })
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment
resource "aws_iam_user_policy_attachment" "ses_user_policy_attachment" {
  user       = aws_iam_user.ses_user.name
  policy_arn = aws_iam_policy.ses_send_policy.arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key
resource "aws_iam_access_key" "ses_user_key" {
  user = aws_iam_user.ses_user.name
}

# --------------------
# Cloudflare DNS
# --------------------

# Cloudflare DNS TXT Record for SES Verification.
resource "cloudflare_dns_record" "ses_verification" {
  comment = "${aws_ses_domain_identity.default.domain} for AWS SES Verification"
  zone_id = var.cloudflare_zone_id
  name    = "_amazonses.${var.dns_record_prefix}"
  content = "\"${aws_ses_domain_identity.default.verification_token}\""
  type    = "TXT"
  proxied = false
  ttl     = 1
}

# Cloudflare DNS CNAME Records for DKIM.
resource "cloudflare_dns_record" "ses_dkim" {
  count   = 3
  comment = "${aws_ses_domain_identity.default.domain} DKIM for AWS SES"
  zone_id = var.cloudflare_zone_id
  name    = "${element(aws_ses_domain_dkim.default.dkim_tokens, count.index)}._domainkey.${var.dns_record_prefix}"
  content = "${element(aws_ses_domain_dkim.default.dkim_tokens, count.index)}.dkim.amazonses.com"
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

# Cloudflare DNS TXT Record for SPF.
resource "cloudflare_dns_record" "ses_spf" {
  comment = "${aws_ses_domain_identity.default.domain} SPF for AWS SES"
  zone_id = var.cloudflare_zone_id
  name    = var.dns_record_prefix
  # "include:_spf.mx.cloudflare.net" is for cloudflare email routing.
  # "include:amazonses.com" is for aws ses.
  content = "\"v=spf1 include:_spf.mx.cloudflare.net include:amazonses.com ~all\""
  type    = "TXT"
  proxied = false
  ttl     = 1
}

# Cloudflare DNS for DMARC
resource "cloudflare_dns_record" "ses_dmarc" {
  comment = "${aws_ses_domain_identity.default.domain} DMARC for AWS SES"
  zone_id = var.cloudflare_zone_id
  name    = "_dmarc.${var.dns_record_prefix}"
  content = "\"v=DMARC1; p=quarantine; adkim=s; aspf=s;\""
  type    = "TXT"
  proxied = false
  ttl     = 1
}
