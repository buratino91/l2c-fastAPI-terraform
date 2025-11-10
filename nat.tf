resource "aws_nat_gateway" "l2c-nat-db-a" {
  subnet_id         = aws_subnet.l2c-db-a.id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat-web-a.id

  depends_on = [aws_internet_gateway.l2c-IGW]
}

resource "aws_nat_gateway" "l2c-nat-db-b" {
  subnet_id         = aws_subnet.l2c-db-b.id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat-web-b.id

  depends_on = [aws_internet_gateway.l2c-IGW]
}