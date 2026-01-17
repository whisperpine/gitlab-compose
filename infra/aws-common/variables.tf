variable "aws_resource_group_name" {
  description = "AWS resource group name"
  type        = string
  validation {
    condition     = length(var.aws_resource_group_name) > 0
    error_message = "resource group name must not be an empty string"
  }
}

variable "default_tags" {
  description = "the filter tags of the resource group"
  type        = map(string)
  validation {
    condition     = length(var.default_tags) > 0
    error_message = "default_tags must contain at least 1 element"
  }
}
