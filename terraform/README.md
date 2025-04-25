# README

Setup Cloudflare Tunnel by Terraform.

## Prerequisites

- A domain hosted by Cloudflare DNS.
- An organization on Cloudflare Zero Trust.
- Terraform of [OpenTofu](https://opentofu.org/) is installed
(`terraform` or `tofu` command is available).\
If OpenTofu is used, substitute `tofu` for
`terraform` in the commands hereafter.

## Get Started

- Create an API Token with [proper permissions](#api-token).
- Configure variables in `terraform.tfvars` file (create if missing).
- Run the following commands:

```sh
cd [terraform-dir]
terraform init
terraform apply -auto-approve
```

## API Token

API Token minimal permissions:

| Permission type | Permission | Access level |
| - | - | - |
| Account | Cloudflare Tunnel | Edit |
| Account | Access: Apps and Policies | Edit |
| Zone | DNS | Edit |

## Tunnel Token

Run the following command to get tunnel token:

```sh
cd [terraform-dir]
terraform output tunnel_token
```

Tunnel Token should be assigned to `CLOUDFLARED_TOKEN` in `.env` file.

## Notes

All the hostnames should target at `https://gitlab`,
including gitlab and container registry.

Enable *No TLS Verify* in public hostname configs, if *https* is used in `EXTERNAL_URL`.\
Because the server-side TLS cert is managed by gitlab-integrated service,
not provided by Cloudflare.

## References

- [Cloudflare Terraform - Cloudflare Docs](https://developers.cloudflare.com/terraform/).
- [Deploy Tunnels with Terraform - Cloudflare Docs](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/deployment-guides/terraform/).
- [Cloudflare Provider - Terraform Registry](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs).
