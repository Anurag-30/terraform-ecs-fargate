output "file_system_id" {
  description = "The ID of the FSx Lustre file system."
  value       = aws_fsx_lustre_file_system.this.id
}

output "dns_name" {
  description = "DNS name of the FSx Lustre file system."
  value       = aws_fsx_lustre_file_system.this.dns_name
}

output "data_repository_association_id" {
  description = "The ID of the data repository association (if created)."
  value       = length(aws_fsx_data_repository_association.this) > 0 ? aws_fsx_data_repository_association.this[0].id : null
}