output "instance_class" {
  description = "The instance class of the RDS instance"
  value       = var.db_cluster_instance_class
}

output "engine" {
  description = "The database engine type"
  value       = var.engine
}

output "engine_version" {
  description = "The database engine version"
  value       = var.db_engine_version
}

output "storage_encrypted" {
  description = "Whether storage encryption is enabled"
  value       = var.storage_encrypted
}

output "multi_az" {
  description = "Whether the RDS instance is multi-AZ"
  value       = var.multi_az
}