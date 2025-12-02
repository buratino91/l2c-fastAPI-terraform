variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "db_AMI_ID" {
  type    = string
  default = "ami-039ff76dec4dfa319"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}