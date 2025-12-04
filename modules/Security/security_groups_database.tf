resource "aws_security_group" "database_SG" {
  name        = "database_SG"
  description = "Security group for database instance"
  vpc_id      = aws_vpc.l2c-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-all-from-fastAPI" {
  security_group_id            = aws_security_group.database_SG.id
  ip_protocol                  = local.all_ip
  referenced_security_group_id = aws_security_group.public_access.id
}

resource "aws_vpc_security_group_egress_rule" "allow-to-endpoint" {
  security_group_id            = aws_security_group.database_SG.id # allow outbound from database to VPC endpoints
  ip_protocol                  = local.tcp_protocol
  from_port                    = var.HTTPS_port_number
  to_port                      = var.HTTPS_port_number
  referenced_security_group_id = aws_security_group.VPC-endpoints.id
}

resource "aws_vpc_security_group_egress_rule" "allow-outbound" {
  security_group_id = aws_security_group.database_SG.id # allow outbound to public
  ip_protocol       = local.all_ip
  cidr_ipv4         = local.cidr_all_ipv4
}

