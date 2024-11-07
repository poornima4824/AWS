variable "vpc_id" {
  type = string
  default = "vpc-0a6cf673aa37f41b2"
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

