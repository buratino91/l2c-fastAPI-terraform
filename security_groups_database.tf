resource "aws_security_group" "database_SG" {
  name        = "database_SG"
  description = "Security group for database instance"
  vpc_id      = aws_vpc.l2c-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-all-from-fastAPI" {
  security_group_id            = aws_security_group.database_SG.id
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.public_access.id
}

resource "aws_vpc_security_group_egress_rule" "allow-to-fastAPI" {
  security_group_id            = aws_security_group.database_SG.id
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.public_access.id
}