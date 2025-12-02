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


resource "aws_vpc" "l2c-vpc" {
  cidr_block                       = "10.16.0.0/24"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true

  tags = {
    Name = "l2c-vpc"
  }
}

resource "aws_internet_gateway" "l2c-IGW" {
  vpc_id = aws_vpc.l2c-vpc.id

  tags = {
    Name = "l2c-vpc1-IGW"
  }
}