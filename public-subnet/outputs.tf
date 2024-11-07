# Public Subnet Output Values

# Public Subnet ID
output "Public_subnet_id" {
  description = "Public Subnet Id"
  value       = aws_subnet.public.id
}

# Public Subnet ARN
output "Public_subnet_arn" {
  description = "The ARN of the Public Subnet"
  value       = aws_subnet.public.arn
}