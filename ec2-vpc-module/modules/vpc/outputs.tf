output "public_subnet_id" {
  description = "Public 서브넷 ID"
  value       = aws_subnet.public_subnet.id
}

output "my_sg_id" {
  description = "보안 그룹 ID"
  value       = aws_security_group.my_sg.id
}
