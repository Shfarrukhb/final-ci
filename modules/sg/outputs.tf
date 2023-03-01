output "bastion_sg_id" {
  value = aws_security_group.Bastion.id
}

output "public_sg_id" {
  value = aws_security_group.Public.id
}

output "private_sg_id" {
  value = aws_security_group.Private.id
}

output "database_sg_id" {
  value = aws_security_group.DB.id
}