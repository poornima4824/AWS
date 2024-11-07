variable "s3_bucket_name" {
  type        = string
  default     = "infraprovassvc12345"
  description = "S3 Bucket Name"
}

variable "force_destroy" {
  type        = bool
  description = "Force destroy the bucket"
  default     = true
}

variable "region" {
  type        = string
  description = "AWS Region"
  default     = "ap-southeast-1"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags which should be assigned to the S3 bucket name"
}

variable "random_suffix_length" {
  description = "Length of the random suffix for the bucket name"
  default     = 8
}

variable "cloudwatch_resources" {
  description = "Set to true to create CloudWatch resources, false otherwise"
  type        = bool
}

variable "sns_topic_name" {
  description = "Name of the SNS topic for CloudWatch alarm notifications"
  type        = string
  default     = "CloudWatch_Notifications_s3"
}

variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
  default     = "S3-Dashboard"
}

variable "s3_bucket_size_threshold" {
  description = "Threshold for S3 bucket size alarm (in bytes)"
  type        = number
  default     = 1000000
}

variable "s3_number_of_objects_threshold" {
  description = "Threshold for number of objects in S3 bucket alarm"
  type        = number
  default     = 1000
}