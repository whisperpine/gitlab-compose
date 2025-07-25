terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.5.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/resourcegroups_group
resource "aws_resourcegroups_group" "default" {
  name = var.aws_resource_group_name
  resource_query {
    query = jsonencode({
      ResourceTypeFilters = ["AWS::AllSupported"]
      TagFilters = [for k, v in var.default_tags : {
        Key    = k
        Values = [v]
      }]
    })
  }
}
