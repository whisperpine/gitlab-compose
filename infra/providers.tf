terraform {
  # S3 backend docs:
  # https://developer.hashicorp.com/terraform/language/backend/s3
  backend "s3" {
    bucket                      = "tf-states"
    key                         = "gitlab/terraform.tfstate"
    endpoints                   = { s3 = "https://00c0277ef0d444bf5c13b03cf8a33405.r2.cloudflarestorage.com" }
    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
    use_lockfile                = true
  }

  # Version constraints docs:
  # https://developer.hashicorp.com/terraform/language/expressions/version-constraints
  required_version = ">= 1.10"
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "~> 1.3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.15.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }
}

# Provider "carlpett/sops" docs: 
# https://registry.terraform.io/providers/carlpett/sops/latest/docs
provider "sops" {}

# Provider "cloudflare/cloudflare" docs:
# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs
provider "cloudflare" {
  api_token = local.cloudflare_token
}

# Provider "hashicorp/aws" docs:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region     = local.aws_provider_region
  access_key = local.aws_access_key_id
  secret_key = local.aws_secret_access_key
  default_tags {
    tags = local.default_tags
  }
}
