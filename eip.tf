# EIPs for nat gateways

resource "aws_eip" "nat-web-a" {
  tags = {
    Name = "natGW-web-a-eip"
  }
}

resource "aws_eip" "nat-web-b" {
  tags = {
    Name = "natGW-web-b-eip"
  }
}


