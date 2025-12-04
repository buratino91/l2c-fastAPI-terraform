variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "HTTPS_port_number" {
  type = number
  default = 443
}

variable "SSH_port_number" {
  type = number
  default = 22
}

variable "HTTP_port_number" {
  type = number
  default = 80
}

variable "my_IP" {
  type = string
  default = "210.10.77.5/32"
}