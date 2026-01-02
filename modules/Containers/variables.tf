variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "container_image" {
  type = string
}

variable "subnets" {
  type = set(string)
}

variable "security_groups" {
  type = set(string)
}