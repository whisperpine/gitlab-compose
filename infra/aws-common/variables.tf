variable "aws_resource_group_name" {
  description = "AWS resource group name"
  type        = string
}

variable "default_tags" {
  description = "the filter tags of the resource group"
  type        = map(string)
}
