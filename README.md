# README

Deploy [GitLab](https://about.gitlab.com/) in your office and access it anywhere.

## File Notes

[gitlab.rb](./gitlab.rb) is duplicated from */etc/gitlab/gitlab.rb* (version v16.7.0-ee), which may be a handy reference.\
[setup-network.sh](./setup-network.sh) demonstrates how to create a docker network
with the [macvlan](https://docs.docker.com/network/drivers/macvlan/) driver type.\
[template.env](./template.env) is a template which is expected to be copied as
[.env](https://docs.docker.com/compose/environment-variables/set-environment-variables/) and edited further.

## Cloudflare Tunnels

[Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/)
provides a secure way to host without a public IP address.\
It's recommended to set up infrastructures like Cloudflare Tunnel by [Terraform](https://www.terraform.io/).

Read more in [terraform/README.md](./terraform/README.md).
