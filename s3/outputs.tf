# S3 Bucket outputs

## S3 Bucket Id
output "s3_bucket_name" {
  description = "Bucket Id"
  value       =  aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_arn" {
  description = "Bucket Arn"
  value = aws_s3_bucket.s3_bucket.arn
}