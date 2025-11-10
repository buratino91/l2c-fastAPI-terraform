variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "fastAPI_AMI_ID" {
  type    = string
  default = "ami-049b1cfcbb3fe0594"
}

variable "db_AMI_ID" {
  type    = string
  default = "ami-039ff76dec4dfa319"
}