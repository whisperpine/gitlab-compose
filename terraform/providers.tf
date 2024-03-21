terraform {
  # version constraints docs:
  # https://developer.hashicorp.com/terraform/language/expressions/version-constraints
  required_version = ">= 1.7.5"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.24"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# cloudflare/cloudflare provider docs:
# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs
provider "cloudflare" {
  api_token = var.cloudflare_token
}

# hashicorp/random provider docs:
# https://registry.terraform.io/providers/hashicorp/random/latest/docs
provider "random" {}
