# README

Deploy [GitLab](https://about.gitlab.com/) in your office and access it anywhere.

## File Notes

[gitlab.rb](./gitlab.rb) is directly copied from */etc/gitlab/gitlab.rb* (version v16.7.0-ee), which is just a reference.\
[setup-network.sh](./setup-network.sh) demonstrates how to create a docker network
with the [macvlan](https://docs.docker.com/network/drivers/macvlan/) driver type.\
[template.env](./template.env) is a template which is expected to be copied as
[.env](https://docs.docker.com/compose/environment-variables/set-environment-variables/) and edited further.

## Cloudflare Tunnels

All the hostnames should target at `https://gitlab`,
including gitlab, container registry and mattermost.

Enable **No TLS Verify** in public hostname configs, if **https** is used in EXTERNAL_URL.\
Because the server-side tls cert is managed by gitlab-integrated service, not provided by Cloudflare.

## Troubleshoot

### SSH does not work

```sh
docker compose exec -it gitlab bash
service ssh restart

# Or use this one-line command.
docker-compose exec gitlab service ssh restart
```
