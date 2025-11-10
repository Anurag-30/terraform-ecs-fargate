variable "name" {
  description = "Name prefix for FSx Lustre file system."
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "AWS Region in which to deploy the FSx Lustre."
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC id where subnets reside."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet ids for FSx Lustre placement."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group ids to assign to FSx Lustre."
  type        = list(string)
  default     = []
}

variable "kms_key_id" {
  description = "KMS Key ARN or ID to encrypt FSx Lustre file system."
  type        = string
  default     = null
}

variable "deployment_type" {
  description = "FSx Lustre deployment type (SCRATCH_1, SCRATCH_2, PERSISTENT_1, PERSISTENT_2)."
  type        = string
  default     = "PERSISTENT_1"
}

variable "storage_capacity" {
  description = "Total storage capacity (GiB) for the FSx Lustre file system."
  type        = number
  default     = 1200
}

variable "storage_type" {
  description = "Type of storage, e.g., SSD or HDD (if supported)."
  type        = string
  default     = "SSD"
}

variable "data_compression_type" {
  description = "Data compression type for FSx Lustre."
  type        = string
  default     = null
}

variable "per_unit_storage_throughput" {
  description = "Throughput per TiB (MB/s/TiB) for PERSISTENT_1 file systems."
  type        = number
  default     = 50
}

variable "data_repository_path" {
  description = "S3 path (e.g., s3://bucket/prefix) for FSx data repository association."
  type        = string
  default     = null
}

variable "file_system_path" {
  description = "Mount path inside FSx for the data repository association."
  type        = string
  default     = "/"
}

variable "s3" {
  description = <<EOT
S3 import/export policies for FSx data repository association.
Example:
s3 = {
  auto_import_policy = ["NEW", "CHANGED"]
  auto_export_policy = ["NEW", "CHANGED", "DELETED"]
}
EOT
  type = object({
    auto_import_policy = optional(list(string), [])
    auto_export_policy = optional(list(string), [])
  })
  default = null
}




