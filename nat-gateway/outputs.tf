# Nat Gateway Output Values

# NAT Gateway
output "nat_gateway_id" {
  description = "NAT Gateway Id"
  value       = aws_route_table_association.rt_association.id
}