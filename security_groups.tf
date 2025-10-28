resource "aws_security_group" "l2c-web-sg" {
  name = "EC2 SG"
  description = "allow HTTPS for EC2 for vpc endpoints"
  vpc_id = aws_vpc.l2c-vpc.id
}

resource "aws_security_group" "VPC-endpoints" {
  name = "VPC endpoint SG"
  description = "SG for VPC endpoints"
  vpc_id = aws_vpc.l2c-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow-https-for-ec2" {
  security_group_id = aws_security_group.l2c-web-sg.id
  ip_protocol = "TCP"
  from_port = 443
  to_port = 443
  cidr_ipv4 = "210.10.77.5/32"

}

resource "aws_vpc_security_group_egress_rule" "allow-https-for-ec2" {
  security_group_id = aws_security_group.l2c-web-sg.id
  ip_protocol = "TCP"
  from_port = 443
  to_port = 443
  referenced_security_group_id =  aws_security_group.VPC-endpoints.id

}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.l2c-web-sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"

}

resource "aws_vpc_security_group_egress_rule" "allow-all-ipv6" {
  security_group_id = aws_security_group.l2c-web-sg.id
  ip_protocol = "-1"
  cidr_ipv6 = "::/0"

}

resource "aws_vpc_security_group_ingress_rule" "allow-https-endpoints" {
  security_group_id = aws_security_group.VPC-endpoints.id
  ip_protocol = "TCP"
  referenced_security_group_id = aws_security_group.l2c-web-sg.id
  from_port = 443
  to_port = 443
}

resource "aws_vpc_security_group_egress_rule" "allow-all-endpoints" {
  security_group_id = aws_security_group.VPC-endpoints.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow-all-endpoints-ipv6" {
  security_group_id = aws_security_group.VPC-endpoints.id
  ip_protocol = "-1"
  cidr_ipv6 = "::/0"
}