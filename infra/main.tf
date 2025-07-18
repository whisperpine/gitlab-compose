# sops_file data docs:
# https://registry.terraform.io/providers/carlpett/sops/latest/docs/data-sources/file
data "sops_file" "default" {
  source_file = "encrypted.${terraform.workspace}.json"
}

locals {
  # provider: cloudflare/cloudflare 
  cloudflare_token = data.sops_file.default.data["cloudflare_token"]
  # provider: hashicorp/aws 
  aws_provider_region   = data.sops_file.default.data["aws_provider_region"]
  aws_access_key_id     = data.sops_file.default.data["aws_access_key_id"]
  aws_secret_access_key = data.sops_file.default.data["aws_secret_access_key"]
  # module: cloudflare_tunnel
  cloudflare_zone            = data.sops_file.default.data["cloudflare_zone"]
  cloudflare_zone_id         = data.sops_file.default.data["cloudflare_zone_id"]
  cloudflare_account_id      = data.sops_file.default.data["cloudflare_account_id"]
  cloudflare_tunnel_name     = data.sops_file.default.data["cloudflare_tunnel_name"]
  dns_record_prefix_gitlab   = data.sops_file.default.data["dns_record_prefix_gitlab"]
  dns_record_prefix_registry = data.sops_file.default.data["dns_record_prefix_registry"]
  # module: aws_s3
  s3_bucket_name = data.sops_file.default.data["s3_bucket_name"]
}

# Create a Cloudflare Tunnel. Add correlated DNS records.
module "cloudflare_tunnel" {
  source                     = "./cloudflare-tunnel"
  cloudflare_zone            = local.cloudflare_zone
  cloudflare_zone_id         = local.cloudflare_zone_id
  cloudflare_account_id      = local.cloudflare_account_id
  cloudflare_tunnel_name     = local.cloudflare_tunnel_name
  dns_record_prefix_gitlab   = local.dns_record_prefix_gitlab
  dns_record_prefix_registry = local.dns_record_prefix_registry
}

# Create an AWS S3 bucket. Add an IAM user with write permission to the bucket.
module "aws_s3" {
  source           = "./aws-s3"
  s3_bucket_region = local.aws_provider_region
  s3_bucket_name   = local.s3_bucket_name
  iam_user_name    = "gitlab-backup-iam"
}
