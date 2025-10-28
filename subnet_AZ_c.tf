resource "aws_subnet" "l2c-web-c" {
  vpc_id = aws_vpc.l2c-vpc.id
  cidr_block = "10.16.0.112/28"
  availability_zone = "us-east-1c"
  ipv6_cidr_block = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 7)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "l2c-web-c"
  }
}

resource "aws_subnet" "l2c-db-c" {
    vpc_id = aws_vpc.l2c-vpc.id
    cidr_block = "10.16.0.128/28"
    availability_zone = "us-east-1c"
    ipv6_cidr_block = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 8)
    assign_ipv6_address_on_creation = true

    tags = {
      Name = "l2c-db-c"
    }
}

resource "aws_subnet" "l2c-reserved-c" {
    vpc_id = aws_vpc.l2c-vpc.id
    cidr_block = "10.16.0.96/28"
    availability_zone = "us-east-1c"
    ipv6_cidr_block = cidrsubnet(aws_vpc.l2c-vpc.ipv6_cidr_block, 8, 6)
    assign_ipv6_address_on_creation = true

    tags = {
      Name = "l2c-reserved-c"
    }
}