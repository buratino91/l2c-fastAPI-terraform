resource "aws_instance" "fastAPI" {
  region                      = var.aws_region
  ami                         = var.fastAPI_AMI_ID
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.l2c-web-a.id
  key_name                    = aws_key_pair.ssh_key.key_name

  user_data = <<EOF
    #!/bin/bash
    sleep 60

    cd journal-starter/
    source .env
    sed -i "s|DATABASE_URL=.*$|DATABASE_URL=postgresql://postgres:$$POSTGRES_PASSWORD@$(aws ec2 describe-instances \
    --filters \
    "Name=tag:Name,Values=Db server" \
    --query 'Reservations[*].Instances[*].PrivateIpAddress' \
    --output text | tr -d ' '):5432/career_journal|" .env

    sed -i "s/server_name.*$$/server_name $(aws ec2 describe-instances \
    --filters \
    "Name=tag:Name,Values=Db server" \
    --query 'Reservations[*].Instances[*].PrivateIpAddress' \
    --output text | tr -d ' ')/" /etc/nginx/conf.d/fastapi_nginx.conf

    service nginx restart
  EOF


  security_groups = [aws_security_group.public_access.id]

  depends_on = [aws_internet_gateway.l2c-IGW]

  iam_instance_profile = aws_iam_instance_profile.ec2-describe-InstanceProfile.name

  tags = {
    Name = "fastAPI_public_server"
  }
}

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

resource "aws_key_pair" "ssh_key" {
  key_name   = "l2c-ssh-key"
  public_key = file(pathexpand("~/.ssh/l2c.pub"))

}