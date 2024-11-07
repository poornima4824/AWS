# Generic Variables
region = "ap-southeast-1"

# S3 Variables
s3_bucket_name                 = "dac-s3"
force_destroy                  = true
cloudwatch_resources           = true
dashboard_name                 = "S3-Dashboard"
sns_topic_name                 = "CloudWatch_Notifications_s3"
s3_bucket_size_threshold       = 1000000
s3_number_of_objects_threshold = 1000
tags = {
  "environment" = "dev"
}