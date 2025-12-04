
resource "aws_security_group" "VPC-endpoints" {
  name        = "VPC endpoint SG"
  description = "SG for VPC endpoints"
  vpc_id      = aws_vpc.l2c-vpc.id
}



resource "aws_vpc_security_group_ingress_rule" "allow-https-endpoints" { # allow HTTPS inbound from database SG
  security_group_id            = aws_security_group.VPC-endpoints.id
  ip_protocol                  = local.tcp_protocol
  referenced_security_group_id = aws_security_group.database_SG.id
  from_port                    = var.HTTPS_port_number
  to_port                      = var.HTTPS_port_number
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.VPC-endpoints.id
  ip_protocol       = local.all_ip
  cidr_ipv4         = local.cidr_all_ipv4
}

resource "aws_vpc_security_group_egress_rule" "allow-all-ipv6" {
  security_group_id = aws_security_group.VPC-endpoints.id
  ip_protocol       = local.all_ip
  cidr_ipv6         = local.cidr_all_ipv6
}

locals {
  all_ip = "-1"
  cidr_all_ipv4 = "0.0.0.0/0"
  tcp_protocol = "TCP"
  cidr_all_ipv6 = "::/0"
}