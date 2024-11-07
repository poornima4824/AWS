# Route Table Association Output Values

# Route Table Association ID
output "route_table_id" {
  description = "Route Table Association Id"
  value       = aws_route_table_association.rt_association.id
}