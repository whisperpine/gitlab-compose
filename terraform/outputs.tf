output "tunnel_token" {
  value     = cloudflare_tunnel.default.tunnel_token
  sensitive = true
}
