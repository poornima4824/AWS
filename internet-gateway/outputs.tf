# Internet Gateway Output Values

# Internet Gateway ID
output "internet_gateway_id" {
  description = "Internet Gateway Id"
  value       = aws_internet_gateway.igw.id
}

# Internet Gateway ARN
output "internet_gateway_arn" {
  description = "The Internet Gateway ARN"
  value       = aws_internet_gateway.igw.arn
}