resource "aws_nat_gateway" "l2c-nat-db-a" {
  subnet_id         = aws_subnet.l2c-web-a.id # nat must exist in public subnet
  connectivity_type = "public"
  allocation_id     = aws_eip.nat-a-eip.id

  depends_on = [aws_internet_gateway.l2c-IGW]
}

resource "aws_nat_gateway" "l2c-nat-db-b" {
  subnet_id         = aws_subnet.l2c-web-b.id # nat must exist in public subnet
  connectivity_type = "public"
  allocation_id     = aws_eip.nat-b-eip.id

  depends_on = [aws_internet_gateway.l2c-IGW]
}