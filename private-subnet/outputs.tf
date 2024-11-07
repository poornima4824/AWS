# Private Subnet Output Values

# Private Subnet ID
output "private_subnet_id" {
  description = "Private Subnet Id"
  value       = aws_subnet.private.id
}

# Private Subnet ARN
output "private_subnet_arn" {
  description = "The ARN of the Private Subnet"
  value       = aws_subnet.private.arn
}