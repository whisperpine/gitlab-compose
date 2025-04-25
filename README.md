# README

Deploy [GitLab](https://about.gitlab.com/) in your office and access it anywhere.

## File Notes

- [gitlab.rb](./gitlab.rb) is duplicated from */etc/gitlab/gitlab.rb*
(version v16.7.0-ee), which may be a handy reference.
- [setup-network.sh](./setup-network.sh) demonstrates how to create a docker network
with the [macvlan](https://docs.docker.com/network/drivers/macvlan/) driver type.
- [example.env](./example.env) is a template which is expected to be copied as
the `.env` file and edited further.

## Cloudflare Tunnels

[Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/)
provides a secure way to host without a public IP address.
It's recommended to set up infrastructures like Cloudflare Tunnel by [Terraform](https://www.terraform.io/).
Read more in [terraform/README.md](./terraform/README.md).

## Feature Flags

On self-hosted GitLab, you may choose to enable or disable certain [feature flags](https://docs.gitlab.com/ee/user/feature_flags).
Refer to GitLab Docs:
[Enable and disable GitLab features deployed behind feature flags](https://docs.gitlab.com/ee/administration/feature_flags).
Here's a quick note:

```sh
# enter interactive tty of gitlab container.
docker compose exec -it gitlab bash
# enter gitlab-rails console (this command may take several minutes).
sudo gitlab-rails console
```

<!-- markdownlint-disable MD033 -->
<details><summary>Commonly used commands in gitlab-rails console</summary>

```rb
# enable "example_feature" feature flag.
Feature.enable(:example_feature)
# check if "example_feature" is enabled.
Feature.enabled?(:example_feature)
# disable "example_feature" feature flag.
Feature.disable(:example_feature)
# unset "example_feature" so that GitLab falls back to the default.
Feature.remove(:example_feature)
```

</details>
<!-- markdownlint-enable MD033 -->
