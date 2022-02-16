variable "name_prefix" {
  description = "Name prefix for resources on AWS"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags"
}

variable "container_definition" {
  description = "Container definition overrides which allows for extra keys or overriding existing keys."
}

variable "subnets" {
  type = list
}

variable "target_group_arn" {  
}

