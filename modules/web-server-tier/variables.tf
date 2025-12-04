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