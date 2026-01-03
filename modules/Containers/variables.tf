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

variable "db_username" {
  type = string
  sensitive = true
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "db_name" {
  type = string
  sensitive = true
}

variable "db_url" {
  type = string
}