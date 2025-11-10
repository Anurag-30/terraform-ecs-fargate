resource "aws_fsx_lustre_file_system" "this" {
  subnet_ids                   = var.subnet_ids
  security_group_ids           = length(var.security_group_ids) > 0 ? var.security_group_ids : null
  deployment_type              = var.deployment_type
  storage_capacity             = var.storage_capacity
  storage_type                 = var.storage_type
  tags                         = local.all_tags
  kms_key_id                   = var.kms_key_id != "" ? var.kms_key_id : null
  data_compression_type        = var.data_compression_type
  per_unit_storage_throughput = var.deployment_type == "PERSISTENT_1" ? var.per_unit_storage_throughput : null
}

resource "aws_fsx_data_repository_association" "this" {
  count                = var.data_repository_path != null ? 1 : 0
  file_system_id       = aws_fsx_lustre_file_system.this.id
  data_repository_path = var.data_repository_path
  file_system_path     = var.file_system_path

  dynamic "s3" {
    for_each = var.s3 != null ? [var.s3] : []
    content {
      dynamic "auto_import_policy" {
        for_each = length(s3.value.auto_import_policy) > 0 ? [1] : []
        content {
          events = s3.value.auto_import_policy
        }
      }

      dynamic "auto_export_policy" {
        for_each = length(s3.value.auto_export_policy) > 0 ? [1] : []
        content {
          events = s3.value.auto_export_policy
        }
      }
    }
  }

  tags = local.all_tags
}