output "security_group_name" {
  description = "SG-name"
  value = aws_security_group.sg_server.name
}

output "security_group_id" {
  description = "SG ID"
  value = aws_security_group.sg_server.id
}