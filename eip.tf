# EIPs for nat gateways

resource "aws_eip" "nat-db-a" {
  tags = {
    Name = "natGW-db-a-eip"
  }
}

resource "aws_eip" "nat-db-b" {
  tags = {
    Name = "natGW-db-b-eip"
  }
}


