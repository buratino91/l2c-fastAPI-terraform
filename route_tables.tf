# route tables for public subnets
resource "aws_route_table" "web-rt" {
  vpc_id = aws_vpc.l2c-vpc.id


  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.l2c-IGW.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.l2c-IGW.id
  }

  tags = {
    Name = "l2c-vpc-rt-web"
  }
}

resource "aws_route_table_association" "web-a-sn-associations" {
  subnet_id      = aws_subnet.l2c-web-a.id
  route_table_id = aws_route_table.web-rt.id
}

resource "aws_route_table_association" "web-b-sn-associations" {
  subnet_id      = aws_subnet.l2c-web-b.id
  route_table_id = aws_route_table.web-rt.id
}

resource "aws_route_table_association" "web-c-sn-associations" {
  subnet_id      = aws_subnet.l2c-web-c.id
  route_table_id = aws_route_table.web-rt.id
}

resource "aws_route_table" "rt-sn-db-a" {
  vpc_id = aws_vpc.l2c-vpc.id


  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.l2c-nat-db-a.id
  }

  tags = {
    Name = "db-a-nat-rt"
  }
}

resource "aws_route_table" "rt-sn-db-b" {
  vpc_id = aws_vpc.l2c-vpc.id


  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.l2c-nat-db-b.id
  }

  tags = {
    Name = "db-b-nat-rt"
  }
}

resource "aws_route_table_association" "l2c-db-a-rt-association" {
  subnet_id      = aws_subnet.l2c-db-a.id
  route_table_id = aws_route_table.rt-sn-db-a.id
}

resource "aws_route_table_association" "l2c-db-b-rt-association" {
  subnet_id      = aws_subnet.l2c-db-b.id
  route_table_id = aws_route_table.rt-sn-db-b.id
}