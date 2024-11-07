variable "create_instance" {
  type    = bool
  default = true  # Set the default value to true if you want the instance to be created by default
}

variable "project_name" {
  type    = string
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "engine" {
  type    = string
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "db_engine_version" {
  type    = string
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "db_cluster_instance_class" {
  type    = string
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "storage" {
  type    = number
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "name" {
  type        = string
  description = "The name of the security group"
  default     = null
}

variable "description" {
  type        = string
  description = "The description of the security group"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
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

variable "name_subnet" {
  description = "The name of the DB subnet group"
  type        = string
  default = null
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the DB subnet group"
  type        = list(string)
  default = null
}



variable "tags" {
  type        = map(string)
  description = "Tags to apply to the security group"
  default     = {}
}


variable "master_username" {
  type    = string
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "master_password" {
  type    = string
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "apply_immediately" {
  type    = bool
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "skip_final_snapshot" {
  type    = bool
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "storage_encrypted" {
  type    = bool
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "backup_retention_period" {
  type    = number
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "license_model" {
  type    = string
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "multi_az" {
  type    = bool
  default = null  # Set the default value to null if you want to specify it when calling the module
}

variable "project_tags" {
  type    = map(string)
  default = null  # Set the default value to null if you want to specify it when calling the module
}
