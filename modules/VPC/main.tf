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

resource "aws_eip" "nat-a-eip" {
  tags = {
    Name = "natGW-a-eip"
  }
}

resource "aws_eip" "nat-b-eip" {
  tags = {
    Name = "natGW-b-eip"
  }
}

locals {
  cidr_ipv6_all = "::/0"
  cidr_ipv4_all = "0.0.0.0/0"
}