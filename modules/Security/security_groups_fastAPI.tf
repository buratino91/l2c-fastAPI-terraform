resource "aws_security_group" "public_access" {
  name        = "public access SG"
  description = "Allow public connection for ingress and egress"
  vpc_id      = var.vpc-id
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-fastAPI" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = local.tcp_protocol
  from_port         = var.SSH_port_number
  to_port           = var.SSH_port_number
  cidr_ipv4         = var.my_IP

}

resource "aws_vpc_security_group_ingress_rule" "allow-http-for-fastAPI" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = local.tcp_protocol
  from_port         = var.HTTP_port_number
  to_port           = var.HTTP_port_number
  cidr_ipv4         = local.cidr_all_ipv4

}

resource "aws_vpc_security_group_egress_rule" "allow-to-database" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = local.all_ip

  referenced_security_group_id = aws_security_group.database_SG.id

}

resource "aws_vpc_security_group_ingress_rule" "allow-all-from-database" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = local.all_ip

  referenced_security_group_id = aws_security_group.database_SG.id
}

resource "aws_vpc_security_group_egress_rule" "allow-all-egress" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = local.all_ip
  cidr_ipv4         = local.cidr_all_ipv4


}