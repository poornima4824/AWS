# VPC Input Variables

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostnames"
  type = bool
  default = true
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type = bool
  default = true
}

variable "instance_tenancy" {
  description = "instance_tenancy"
  type = string
  default = "default"
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags which should be assigned to the S3 bucket name"
}