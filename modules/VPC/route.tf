# route tables for public subnets
resource "aws_route_table" "web-rt" {
  vpc_id = aws_vpc.l2c-vpc.id


  route {
    ipv6_cidr_block = local.cidr_ipv6_all
    gateway_id      = aws_internet_gateway.l2c-IGW.id
  }

  route {
    cidr_block = local.cidr_ipv4_all
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
    cidr_block     = local.cidr_ipv4_all
    nat_gateway_id = aws_nat_gateway.l2c-nat-db-a.id
  }

  tags = {
    Name = "db-a-nat-rt"
  }
}

resource "aws_route_table" "rt-sn-db-b" {
  vpc_id = aws_vpc.l2c-vpc.id


  route {
    cidr_block     = local.cidr_ipv4_all
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

resource "aws_subnet" "l2c-web-a" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.16/28"
  availability_zone               = var.az_a
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-web-a"
  }
}

resource "aws_subnet" "l2c-db-a" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.32/28"
  availability_zone               = var.az_a
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 2)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-db-a"
  }
}

resource "aws_subnet" "l2c-reserved-a" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.0/28"
  availability_zone               = var.az_a
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 0)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-reserved-a"
  }
}

resource "aws_subnet" "l2c-web-b" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.64/28"
  availability_zone               = var.az_b
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 3)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-web-b"
  }
}

resource "aws_subnet" "l2c-db-b" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.80/28"
  availability_zone               = var.az_b
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 4)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-db-b"
  }
}

resource "aws_subnet" "l2c-reserved-b" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.48/28"
  availability_zone               = var.az_b
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 5)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-reserved-b"
  }
}

resource "aws_subnet" "l2c-web-c" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.112/28"
  availability_zone               = var.az_c
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 7)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-web-c"
  }
}

resource "aws_subnet" "l2c-db-c" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.128/28"
  availability_zone               = var.az_c
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 8)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-db-c"
  }
}

resource "aws_subnet" "l2c-reserved-c" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.96/28"
  availability_zone               = var.az_c
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 6)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-reserved-c"
  }
}