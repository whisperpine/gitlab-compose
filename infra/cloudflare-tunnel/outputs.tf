output "tunnel_token" {
  description = "It should be assigned to CLOUDFLARED_TOKEN in .env"
  value       = data.cloudflare_zero_trust_tunnel_cloudflared_token.default.token
  sensitive   = true
}

output "tunnel_dns_records" {
  description = "The DNS records of published application routes"
  value = [
    cloudflare_dns_record.gitlab.name,
    cloudflare_dns_record.registry.name
  ]
  sensitive = true
}
