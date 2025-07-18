output "tunnel_token" {
  description = "It should be assigned to CLOUDFLARED_TOKEN in .env"
  value       = data.cloudflare_zero_trust_tunnel_cloudflared_token.default.token
  sensitive   = true
}
