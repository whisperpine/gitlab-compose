variable "cloudflare_zone" {
  description = "Zone is the domain (e.g. example.com)"
  type        = string
  validation {
    condition = (
      length(var.cloudflare_zone) >= 3 &&
      length(var.cloudflare_zone) <= 253 &&
      # Only allowed characters: letters, digits, hyphen, dot.
      can(regex("^[a-zA-Z0-9][a-zA-Z0-9.-]*[a-zA-Z0-9]$", var.cloudflare_zone)) &&
      # No consecutive dots.
      !can(regex("[.]{2,}", var.cloudflare_zone)) &&
      # No leading or trailing dot.
      !startswith(var.cloudflare_zone, ".") &&
      !endswith(var.cloudflare_zone, ".") &&
      # No hyphen at start or end of any label.
      !can(regex("(^|-)[.-]*\\.|\\.[.-]*(?=$|-)", var.cloudflare_zone)) &&
      # Each label ≤ 63 characters.
      alltrue([
        for label in split(".", var.cloudflare_zone) :
        length(label) <= 63
      ])
    )
    error_message = <<-EOF
      Domain name is not valid. It must satisfy ALL of the following:
        - 3–253 characters total length
        - Allowed characters: a–z, A–Z, 0–9, hyphen (-), dot (.)
        - Must not start or end with a dot
        - Must not contain consecutive dots
        - No label (part between dots) may start or end with a hyphen
        - Each label must be 1–63 characters long
        - Must contain at least one dot (not a TLD alone like "com")
      EOF
  }
}

variable "cloudflare_zone_id" {
  description = "Zone ID for your domain"
  type        = string
  validation {
    condition     = length(var.cloudflare_zone_id) == 32
    error_message = "it must be a string with 32 characters"
  }
  validation {
    condition     = can(regex("^[0-9a-f]+$", var.cloudflare_zone_id))
    error_message = "every character must be a valid hexadecimal number"
  }
}

variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.cloudflare_account_id) == 32
    error_message = "it must be a string with 32 characters"
  }
  validation {
    condition     = can(regex("^[0-9a-f]+$", var.cloudflare_account_id))
    error_message = "every character must be a valid hexadecimal number"
  }
}

variable "cloudflare_tunnel_name" {
  description = "The name of cloudflare tunnel"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.cloudflare_tunnel_name))
    error_message = "it must contain only lowercase letters, numbers, and hyphens"
  }
}

variable "dns_record_prefix_gitlab" {
  description = "The dns record prefix for gitlab"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.dns_record_prefix_gitlab))
    error_message = "it must contain only lowercase letters, numbers, and hyphens"
  }
}

variable "dns_record_prefix_registry" {
  description = "The dns record prefix for container registry"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.dns_record_prefix_registry))
    error_message = "it must contain only lowercase letters, numbers, and hyphens"
  }
}
