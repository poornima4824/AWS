variable "env" {
  description = "The deployment environment for the RDS instance. Common values include 'dev', 'test', 'staging', and 'prod'."
  type        = string
  default     = "rds-mysql"
}
variable "db_instance_identifier" {
  description = "The unique identifier for the RDS instance. This name must be unique within each AWS region for your AWS account."
  type        = string
  default     = "my-rds-instance"
}
variable "db_engine" {
  description = "The database engine to use for the RDS instance. Supported values include 'mysql', 'postgres', 'oracle-ee', 'sqlserver-ee', 'sqlserver-se', 'sqlserver-ex', and 'sqlserver-web'."
  type        = string
  default     = "postgres"
}
variable "performance_insights_enabled" {
  description = "Indicates whether Performance Insights are enabled for the RDS instance. This provides detailed database performance metrics."
  type        = bool
  default     = false
}

variable "ingress_rules" {
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "List of ingress rules"
  default     = null
}

variable "subnet_ids" {
  type = list(string)
}

variable "db_engine_version" {
  description = "The version of the database engine to use. Ensure this is compatible with the 'db_engine' specified."
  type        = string
  default     = "15.5-R2"
}
variable "storage" {
  description = "The allocated storage in gigabytes for the RDS instance. This value depends on the DB instance class and storage type."
  type        = string
  default     = "200"
}
variable "private_subnet_2" {
  description = "List of subnet IDs for the Batch compute environment."
  type        = list(string)
  default =  ["subnet-03bfb0c575866eb1e","subnet-065684815f2dd01d8", "subnet-02449d95197e54041"]
}

variable "name_subnet" {
  type = string
}
variable "audit_plugin_server_audit_events" {
  description = "A comma-separated list of server audit events to enable. Possible events include 'CONNECT', 'QUERY', and 'TABLE'."
  type        = string
  default     = "CONNECT,QUERY,TABLE"
}

variable "storage_type" {
  description = "The storage type to be used by the RDS instance. Common types include 'gp2' for General Purpose SSD, 'io1' for Provisioned IOPS SSD, and 'standard' for Magnetic storage."
  type        = string
  default     = "io1"
}
variable "db_cluster_instance_class" {
  description = "The compute and memory capacity of each DB instance in the Multi-AZ DB cluster, for example db.m6g.xlarge. Not all DB instance classes are available in all AWS Regions, or for all database engines"
  type        = string
  default     = null
}
variable "region" {
  description = "The AWS region where the resources will be created. This determines where your resources are physically hosted."
  type        = string
  default     = "ap-southeast-1"
}
variable "project_name" {
  description = "Name of the RDS project"
  type        = string
  default     = "rds-dac-project"
}
variable "project_tags" {
  description = "Tags for the RDS project"
  type        = map(string)
  default = {
    Name = "DAC"
  }
}
variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}
variable "engine" {
  description = "The database engine to use for the RDS instance."
  type        = string
}
variable "iops" {
  description = "The number of Provisioned IOPS (Input/Output operations per second) for the RDS instance. This setting is only used when 'storage_type' is set to 'io1'."
  type        = string
  default     = "1000"
}
variable "storage_encrypted" {
  description = "Flag to enable storage encryption"
  type        = bool
}
variable "master_username" {
  description = "Master username for database"
  type        = string
  default     = "root"
}
variable "vpc_spoke_public_subnet_cidrs" {
  description = "The list of existing public subnet CIDRs in the VPC."
  type        = list(string)
}
variable "monitoring_interval" {
  description = "Monitoring interval for database"
  type        = number
}
variable "apply_immediately" {
  description = "Flag to apply changes immediately"
  type        = bool
}
variable "skip_final_snapshot" {
  description = "Flag to skip the final snapshot"
  type        = bool
}
variable "scaling_configuration" {
  description = "Scaling configuration for database"
  type = object({
    auto_pause               = bool
    min_capacity             = number
    max_capacity             = number
    seconds_until_auto_pause = number
    timeout_action           = string
  })
}
variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed."
  type        = bool
}
variable "auto_minor_version_upgrade" {
  type = bool
}
variable "backup_retention_period" {
  description = "The number of days during which automatic DB snapshots are retained."
  type        = number
}
variable "copy_tags_to_snapshot" {
  description = "Indicates whether to copy all tags from the DB instance to snapshots of the DB instance."
  type        = bool
}
variable "database_name" {
  description = "The name of the default database to create when the DB instance is created."
  type        = string
}
variable "delete_automated_backups" {
  description = "Indicates whether automated backups are deleted when the DB instance is deleted."
  type        = bool
}
variable "deletion_protection" {
  description = "Indicates whether the DB instance has deletion protection enabled."
  type        = bool
}
variable "final_snapshot_identifier" {
  description = "The name of your DB instance final snapshot."
  type        = string
}
variable "master_password" {
  description = "The password for the master user account in the RDS instance. This password should be strong and securely managed."
  type        = string
}
variable "database_engine_ports" {
  description = "A map defining the default port numbers for various database engines. This allows for easy reference and configuration when setting up database connections. Currently includes ports for MySQL, with placeholders for Oracle and Microsoft SQL Server that can be uncommented and adjusted as needed."
  type        = map(number)
  default = {
    #"mysql" = 3306
    # Uncomment and adjust the following lines as necessary for your specific database requirements.
    # "oracle" = 1521
    # "mssql" = 1433
  }
}
variable "license_model" {
  description = "The license model for the DB instance. Use 'license-included' for SQL Server."
  type        = string
  default     = "license-included"
}
variable "multi_az" {
  description = "Specifies if the RDS instance should be deployed across multiple Availability Zones for high availability."
  type        = bool
  default     = false
}