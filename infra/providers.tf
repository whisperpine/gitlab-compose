terraform {
  backend "s3" {
    bucket                      = "tf-states"
    key                         = "gitlab/terraform.tfstate"
    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }

  # version constraints docs:
  # https://developer.hashicorp.com/terraform/language/expressions/version-constraints
  required_version = ">= 1.10"
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "~> 1.2.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.7.0"
    }
  }
}

# cloudflare/cloudflare provider docs:
# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs
provider "cloudflare" {
  api_token = local.cloudflare_token
}

# carlpett/sops provider docs: 
# https://registry.terraform.io/providers/carlpett/sops/latest/docs
provider "sops" {}
