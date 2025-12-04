output "instanceProfile_name" {
  description = "name of ec2 instance profile"
  value = aws_iam_instance_profile.SSM_ec2_InstanceProfile.name
}

output "db_securitygroups" {
  description = "ID of security group for Db"
  value = aws_security_group.database_SG.id
}

output "vpcEndpoint_SG_id" {
  description = "ID of security group for VPC endpoints"
  value = aws_security_group.VPC-endpoints.id
}

output "publicAccess_SG_id" {
  description = "ID of security group for public access"
  value = aws_security_group.public_access.id
}

output "iam_instance_profile_describeEC2" {
  description = "Name of IAM instance profile to allow retrieval of EC2 private address"
  value = aws_iam_instance_profile.ec2-describe-InstanceProfile.name
}