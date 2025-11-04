resource "aws_subnet" "l2c-web-a" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.16/28"
  availability_zone               = "us-east-1a"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-web-a"
  }
}

resource "aws_subnet" "l2c-db-a" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.32/28"
  availability_zone               = "us-east-1a"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 2)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-db-a"
  }
}

resource "aws_subnet" "l2c-reserved-a" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.0/28"
  availability_zone               = "us-east-1a"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 0)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-reserved-a"
  }
}