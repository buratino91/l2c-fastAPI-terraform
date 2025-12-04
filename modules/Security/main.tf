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

resource "aws_iam_role" "SSM_ec2_Role" {
  name = "SSM_ec2_Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "ec2-describe-role" {
  name = "ec2-describe-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "SSM_Role-attach" {
  role       = aws_iam_role.SSM_ec2_Role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "SSM_ec2_InstanceProfile" {
  name = "ec2-Instance-Profile"
  role = aws_iam_role.SSM_ec2_Role.name
}

# Policy for ec2 to describe instance (retrive IP address)
resource "aws_iam_role_policy_attachment" "ec2_describe" {
  role       = aws_iam_role.ec2-describe-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2-describe-InstanceProfile" {
  name = "ec2-describe-InstanceProfile"
  role = aws_iam_role.ec2-describe-role.name
}