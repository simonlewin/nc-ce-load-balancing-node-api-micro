output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "public_subnets" {
  value       = aws_subnet.public[*].id
  description = "List of IDs of the public subnets"
}

output "private_subnets" {
  value       = aws_subnet.private[*].id
  description = "List of IDs of the private subnets"
}
