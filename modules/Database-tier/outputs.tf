output "database_ip" {
  value = aws_instance.postgresql.private_ip
}