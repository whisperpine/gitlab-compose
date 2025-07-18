# Cloudflare Tunnel Module

- Create a Cloudflare Tunnel.
- Add correlated DNS records.

## References

- [Cloudflare Terraform - Cloudflare Docs](https://developers.cloudflare.com/terraform/).
- [Deploy Tunnels with Terraform - Cloudflare Docs](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/deployment-guides/terraform/).
- [Cloudflare Provider - Terraform Registry](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs).

## Prerequisites

- A domain hosted by Cloudflare DNS (so that DNS records could be managed
  by terraform).
- An organization on Cloudflare Zero Trust (in order to configure Cloudflare Tunnel).
- Create an API Token with proper permissions (see [API Token](#api-token) below).

## API Token

API Token minimal permissions:

| Permission type | Permission | Access level |
| - | - | - |
| Account | Cloudflare Tunnel | Edit |
| Account | Access: Apps and Policies | Edit |
| Zone | DNS | Edit |

## Notes

All the hostnames should target at `https://gitlab`,
including gitlab and container registry.

Enable *No TLS Verify* in public hostname configs, if *https* is used in `EXTERNAL_URL`.\
Because the server-side TLS cert is managed by gitlab-integrated service,
not provided by Cloudflare.
