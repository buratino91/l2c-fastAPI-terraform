output "webserver_publicIP" {
  description = "Public IP address of the web server EC2 instance"
  value = aws_instance.fastAPI.public_ip
}