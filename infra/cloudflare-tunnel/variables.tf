variable "cloudflare_zone" {
  description = "Zone is the domain (e.g. example.com)"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Zone ID for your domain"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_tunnel_name" {
  description = "The name of cloudflare tunnel"
  type        = string
}

variable "dns_record_prefix_gitlab" {
  description = "The dns record prefix for gitlab"
  type        = string
}

variable "dns_record_prefix_registry" {
  description = "The dns record prefix for container registry"
  type        = string
}
