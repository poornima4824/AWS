output "vpc_endpoint_id" {
  description = "The ID of the VPC endpoint for S3"
  value       = aws_vpc_endpoint.vpc_endpoint_for_s3.id
}
