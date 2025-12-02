resource "aws_instance" "postgresql" {
  region                      = var.aws_region
  ami                         = var.db_AMI_ID
  instance_type               = var.instance_type
  associate_public_ip_address = false

  subnet_id            = aws_subnet.l2c-db-a.id
  iam_instance_profile = aws_iam_instance_profile.SSM_ec2_InstanceProfile.name



  security_groups = [aws_security_group.database_SG.id]
  tags = {
    Name = "Db server"
  }
}