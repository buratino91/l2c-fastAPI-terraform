terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
  required_version = ">= 1.2.0"


}


provider "aws" {
  region = var.aws_region
}

module "l2c-vpc" {
  source             = "./modules/VPC"
  vpc_endpoint_SG_id = module.security_policies.vpcEndpoint_SG_id
}

# module "database" {
#   source = "./modules/Database-tier"
#   subnet_id = module.l2c-vpc.db_a_subnetID
#   iam_profile = module.security_policies.instanceProfile_name
#   security_groups = module.security_policies.db_securitygroups
# }

# module "web_server" {
#   source = "./modules/web-server-tier"
#   instance_type = "t3.micro"
#   subnet_id = module.l2c-vpc.web_a_subnetID
#   PublicAccess_SG_ID = module.security_policies.publicAccess_SG_id
#   iam_instance_profile = module.security_policies.iam_instance_profile_describeEC2
# }

module "security_policies" {
  source = "./modules/Security"
  vpc-id = module.l2c-vpc.vpc_id
}

module "ecs_containers" {
  source          = "./modules/Containers"
  container_image = "docker.io/glen912/l2c-journal_app:v2"
  subnets         = [module.l2c-vpc.web_a_subnetID, module.l2c-vpc.web_b_subnetID]
  security_groups = [module.security_policies.publicAccess_SG_id]
  db_name = var.db_name
  db_password = var.db_password
  db_url = module.rds.db_instance_address
  db_username = var.db_username
}

module "rds" {
  source                 = "terraform-aws-modules/rds/aws"
  version                = "7.0.0"
  identifier             = "l2c-journal-db"
  vpc_security_group_ids = [module.security_policies.db_securitygroups]
  create_db_subnet_group = true
  subnet_ids = module.l2c-vpc.db_subnet_ids
  engine                 = "postgres"
  family                 = "postgres17"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = "postgres"
}

output "db_instance" {
  value = module.rds.db_instance_endpoint
}

output "db_instance_address" {
  value = module.rds.db_instance_address
}
# module "ssm_parameters" {
#   source = "./modules/Parameters"
#   db_instance_address = module.rds.db_instance_address
#   db_username = var.db_username
#   db_password = var.db_password
#   db_name = var.db_name
# }