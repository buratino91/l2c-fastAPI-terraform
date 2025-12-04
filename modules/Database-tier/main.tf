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

resource "aws_instance" "postgresql" {
  region                      = var.aws_region
  ami                         = var.db_AMI_ID
  instance_type               = var.instance_type
  associate_public_ip_address = false

  subnet_id            = var.subnet_id
  iam_instance_profile = var.iam_profile



  security_groups = [var.security_groups]
  tags = {
    Name = "Db server"
  }
}