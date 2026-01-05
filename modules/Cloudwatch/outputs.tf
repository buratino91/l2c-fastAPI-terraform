output "log_group_name" {
  description = "Cloudwatch log group name"
  value       = aws_cloudwatch_log_group.ecs_logs.name
}