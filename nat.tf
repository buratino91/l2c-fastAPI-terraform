resource "aws_nat_gateway" "l2c-nat-db-a" {
  subnet_id         = aws_subnet.l2c-db-a.id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat-db-a.id

  depends_on = [aws_vpc.l2c-vpc]
}

resource "aws_nat_gateway" "l2c-nat-db-b" {
  subnet_id         = aws_subnet.l2c-db-b.id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat-db-b.id

  depends_on = [aws_vpc.l2c-vpc]
}