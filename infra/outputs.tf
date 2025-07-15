output "tunnel_token" {
  value     = module.cloudflare_tunnel.tunnel_token
  sensitive = true
}
