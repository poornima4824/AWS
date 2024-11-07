variable "vpc_id" {
  type = string
  default = "vpc-0731900d6bd65b956"
  description = "VPC Id"
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