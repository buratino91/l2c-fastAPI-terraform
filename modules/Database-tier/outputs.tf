output "database_ip" {
    description = "Private IP address of the database EC2 instance"
    value = aws_instance.postgresql.private_ip
}