resource "aws_vpc_endpoint" "ec2messages" {

  vpc_id = aws_vpc.l2c-vpc.id

  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.VPC-endpoints.id]

  subnet_ids = [aws_subnet.l2c-db-a.id, aws_subnet.l2c-db-b.id]

  service_name = "com.amazonaws.us-east-1.ec2messages"

}



resource "aws_vpc_endpoint" "ssm" {

  vpc_id = aws_vpc.l2c-vpc.id

  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.VPC-endpoints.id]

  subnet_ids = [aws_subnet.l2c-db-a.id, aws_subnet.l2c-db-b.id]

  service_name = "com.amazonaws.us-east-1.ssm"

}



resource "aws_vpc_endpoint" "ssmmessages" {

  vpc_id = aws_vpc.l2c-vpc.id

  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.VPC-endpoints.id]

  subnet_ids = [aws_subnet.l2c-db-a.id, aws_subnet.l2c-db-b.id]

  service_name = "com.amazonaws.us-east-1.ssmmessages"

}