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
  source = "./modules/VPC"
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
  source = "./modules/Containers"
  container_image = "docker.io/glen912/l2c-journal_app:latest"
  subnets = [ module.l2c-vpc.web_a_subnetID, module.l2c-vpc.web_b_subnetID ]
  security_groups = [ module.security_policies.publicAccess_SG_id ]
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "7.0.0"
  identifier = "l2c-journal-db"
  vpc_security_group_ids = [module.security_policies.db_securitygroups ]
  db_subnet_group_name = module.l2c-vpc.db_a_subnetID
  # engine = "postgres"
  family = "postgres17"
  create_db_option_group = false
  instance_class = "t3.micro"
}