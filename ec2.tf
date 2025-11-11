resource "aws_instance" "fastAPI" {
  region                      = var.aws_region
  ami                         = var.fastAPI_AMI_ID
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.l2c-web-a.id
  key_name                    = aws_key_pair.ssh_key.key_name

  security_groups = [aws_security_group.public_access.id]
  
  depends_on = [aws_internet_gateway.l2c-IGW]

  tags = {
    Name = "fastAPI_public_server"
  }
}

resource "aws_instance" "postgresql" {
  region                      = var.aws_region
  ami                         = var.db_AMI_ID
  instance_type               = var.instance_type
  associate_public_ip_address = false

  subnet_id = aws_subnet.l2c-db-a.id
  iam_instance_profile = aws_iam_instance_profile.SSMInstanceProfile.name

  security_groups = [aws_security_group.database_SG.id]

  tags = {
    Name = "Db server"
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "l2c-ssh-key"
  public_key = file(pathexpand("~/.ssh/test.pub"))

}