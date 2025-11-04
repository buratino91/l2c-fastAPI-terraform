resource "aws_instance" "fastAPI" {
  region                      = var.aws_region
  ami                         = "ami-049b1cfcbb3fe0594"
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.l2c-web-a.id
  key_name                    = aws_key_pair.ssh_key.key_name

  security_groups = [aws_security_group.public_access.id]

  tags = {
    Name = "fastAPI_public_server"
  }
}

resource "aws_instance" "postgresql" {
  region                      = var.aws_region
  ami                         = "ami-039ff76dec4dfa319"
  instance_type               = var.instance_type
  associate_public_ip_address = false

  subnet_id = aws_subnet.l2c-db-a.id

  security_groups = [aws_security_group.database_SG.id]

  tags = {
    Name = "Db server"
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "l2c-ssh-key"
  public_key = file("/Users/glenchua/Downloads/l2c_pub.pem")

}