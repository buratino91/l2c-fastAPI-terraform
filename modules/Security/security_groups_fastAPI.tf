resource "aws_security_group" "public_access" {
  name        = "public access SG"
  description = "Allow public connection for ingress and egress"
  vpc_id      = aws_vpc.l2c-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-fastAPI" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = "TCP"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "210.10.77.5/32"

}

resource "aws_vpc_security_group_ingress_rule" "allow-http-for-fastAPI" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = "TCP"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"

}

resource "aws_vpc_security_group_egress_rule" "allow-to-database" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = "-1"

  referenced_security_group_id = aws_security_group.database_SG.id

}

resource "aws_vpc_security_group_ingress_rule" "allow-all-from-database" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = "-1"

  referenced_security_group_id = aws_security_group.database_SG.id
}

resource "aws_vpc_security_group_egress_rule" "allow-all-egress" {
  security_group_id = aws_security_group.public_access.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"


}