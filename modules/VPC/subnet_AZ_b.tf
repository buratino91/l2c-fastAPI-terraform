resource "aws_subnet" "l2c-web-b" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.64/28"
  availability_zone               = "us-east-1b"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 3)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-web-b"
  }
}

resource "aws_subnet" "l2c-db-b" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.80/28"
  availability_zone               = "us-east-1b"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 4)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-db-b"
  }
}

resource "aws_subnet" "l2c-reserved-b" {
  vpc_id                          = aws_vpc.l2c-vpc.id
  cidr_block                      = "10.16.0.48/28"
  availability_zone               = "us-east-1b"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 5)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-reserved-b"
  }
}