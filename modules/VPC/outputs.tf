output "db_a_subnetID" {
  description = "Subnet ID of database subnet in AZ-A"
  value = aws_subnet.l2c-db-a.id
}

output "db_b_subnetID" {
  description = "Subnet ID of database subnet in AZ-B"
  value = aws_subnet.l2c-db-b.id
}

output "db_c_subnetID" {
  description = "Subnet ID of database subnet in AZ-C"
  value = aws_subnet.l2c-db-c.id
}

output "web_a_subnetID" {
  description = "Subnet ID of web subnet in AZ-A"
  value = aws_subnet.l2c-web-a.id
}

output "web_b_subnetID" {
  description = "Subnet ID of web subnet in AZ-B"
  value = aws_subnet.l2c-web-b.id
}

output "web_c_subnetID" {
  description = "Subnet ID of web subnet in AZ-C"
  value = aws_subnet.l2c-web-c.id
}

output "vpc_id" {
    description = "ID of VPC"
    value = aws_vpc.l2c-vpc.id
}