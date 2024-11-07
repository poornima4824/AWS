variable "vpc_id" {
  type = string
  default = "vpc-0731900d6bd65b956"
  description = "VPC Id"
}

variable "public_subnet_cidr_block" {
  description = "Publis Subnet CIDR Block"
  type = string 
  default = "10.0.0.0/20"
}

variable "availability_zone" {
  type = string
  default = "us-east-1a"
  description = "Availability Zone"
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags which should be assigned to the resource"
}