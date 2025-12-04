terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.2.0"


}


provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "fastAPI" {
  region                      = var.aws_region
  ami                         = var.fastAPI_AMI_ID
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair.ssh_key.key_name

  user_data = <<-EOF
    #!/bin/bash
    sleep 60

    cd /home/ec2-user/journal-starter
    source .env 
    sed -i "s|DATABASE_URL=.*$|DATABASE_URL=postgresql://postgres:$${POSTGRES_PASSWORD}@$(aws ec2 describe-instances \
    --filters \
    "Name=tag:Name,Values=Db server" \
    --query 'Reservations[*].Instances[*].PrivateIpAddress' \
    --output text | tr -d ' '):5432/career_journal|" .env

    sed -i "s/server_name.*$/server_name $(aws ec2 describe-instances \
    --filters \
    "Name=tag:Name,Values=Db server" \
    --query 'Reservations[*].Instances[*].PrivateIpAddress' \
    --output text | tr -d ' ');/" /etc/nginx/conf.d/fastapi_nginx.conf

    service nginx restart

    ./start.sh
  EOF


  security_groups = [var.PublicAccess_SG_ID]

  iam_instance_profile = var.iam_instance_profile

  tags = {
    Name = "fastAPI_public_server"
  }
}



resource "aws_key_pair" "ssh_key" {
  key_name   = "l2c-ssh-key"
  public_key = file(pathexpand("~/.ssh/l2c.pub"))

}