output "http_group_id" {
  value       = aws_security_group.allow_http.id
  description = "The ID of the HTTP security group"
}

output "ssh_group_id" {
  value       = aws_security_group.allow_ssh.id
  description = "The ID of the SSH security group"
}
