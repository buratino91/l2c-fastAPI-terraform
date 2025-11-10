
resource "aws_security_group" "VPC-endpoints" {
  name        = "VPC endpoint SG"
  description = "SG for VPC endpoints"
  vpc_id      = aws_vpc.l2c-vpc.id
}



resource "aws_vpc_security_group_ingress_rule" "allow-https-endpoints" { # allow HTTPS inbound from database SG
  security_group_id            = aws_security_group.VPC-endpoints.id
  ip_protocol                  = "TCP"
  referenced_security_group_id = aws_security_group.database_SG.id 
  from_port                    = 443
  to_port                      = 443
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.VPC-endpoints.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow-all-ipv6" {
  security_group_id = aws_security_group.VPC-endpoints.id
  ip_protocol       = "-1"
  cidr_ipv6         = "::/0"
}