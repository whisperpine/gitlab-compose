# README

Deploy [GitLab](https://about.gitlab.com/) with Docker Compose.

## Notes

[gitlab.rb](./gitlab.rb) is directly copied from */etc/gitlab/gitlab.rb* (version v16.7.0-ee), which is just a reference.\
[setup-network.sh](./setup-network.sh) demonstrates how to create a docker network
with the [macvlan](https://docs.docker.com/network/drivers/macvlan/) driver type.\
[template.env](./template.env) is a template which is expected to get copied as
[.env](https://docs.docker.com/compose/environment-variables/set-environment-variables/) and edited further.
