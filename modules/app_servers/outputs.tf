output "instance_ids" {
  value       = aws_instance.app_servers[*].id
  description = "List of IDs of the instances"
}
