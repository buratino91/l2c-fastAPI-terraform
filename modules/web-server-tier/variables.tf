variable "instance_type" {
  type    = string
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "fastAPI_AMI_ID" {
  type    = string
  default = "ami-049b1cfcbb3fe0594"
}

variable "subnet_id" {
  type = string
}

variable "PublicAccess_SG_ID" {
  type = string
  description = "ID of security group for public subnet"
}

variable "iam_instance_profile" {
  type = string
  description = "IAM instance profile name to allow retrieval of IP address of database ec2"
}