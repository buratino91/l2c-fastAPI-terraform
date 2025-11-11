# EIPs for nat gateways

resource "aws_eip" "nat-a-eip" {
  tags = {
    Name = "natGW-a-eip"
  }
}

resource "aws_eip" "nat-b-eip" {
  tags = {
    Name = "natGW-b-eip"
  }
}


