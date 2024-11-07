variable "create_vpc_endpoint" {
  type        = bool
  description = "Whether to create a VPC endpoint"
  default     = false
}
variable "key_name" {
  type        = string
  description = "Name of the SSH key pair"
  default     = "key_name"
}
variable "role_name" {
  type        = string
  description = "Name of the iam role name"
  default     = "role_name"
}
variable "profile_name" {
  type        = string
  description = "Name of the iam profile name"
  default     = "profile_name"
}
variable "policy_name" {
  type        = string
  description = "Name of the iam policy name"
  default     = "policy_name"
}
variable "security_group" {
  type        = string
  description = "Name of the security group name"
  default     = "security_group"
}
variable "ec2_type" {
  type        = string
  description = "Type of EC2 instance"
  default     = "ec2_type"
}
variable "create_aws_iam_instance_profile" {
  type        = bool
  description = "Whether to create an IAM instance profile"
  default     = false
}
variable "create_aws_iam_role" {
  type        = bool
  description = "Whether to create an IAM role"
  default     = false
}
variable "create_aws_iam_role_policy_attachment" {
  type        = bool
  description = "Whether to attach an IAM policy to an IAM role"
  default     = false
}
variable "create_aws_iam_policy" {
  type        = bool
  description = "Whether to create an IAM policy"
  default     = false
}
variable "public_subnet" {
  type        = string
  description = "ID of the public subnet"
  default     = "public_subnet"
}
variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
  default     = "vpc_id"
}
variable "ec2_amiid" {
  type        = string
  description = "ID of the EC2 AMI"
  default     = "ec2_amiid"
}
variable "windows_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = true
}
variable "region" {
  description = "(Required) AWS region where the resources will be deployed."
  type        = string
  default     = "ap-southeast-1"
}
variable "security_group_tags" {
  type        = map(string)
  description = "Tags for the VPC Link"
}
variable "tags" {
  description = "A mapping of tags which should be assigned to the resources"
  type        = map(string)
  default     = {}
}