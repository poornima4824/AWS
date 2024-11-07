# Route Table Output Values

# Route Table ID
output "route_table_id" {
  description = "Route Table Id"
  value       = aws_route_table.rt.id
}

# Route Table ARN
output "route_table_arn" {
  description = "The Route Table ARN"
  value       = aws_route_table.rt.arn
}