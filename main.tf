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

# Configure terraform to store state in S3 bucket
terraform {
  backend "s3" {
    
    bucket       = "l2c-state"
    key          = "global/s3/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true


    encrypt = true

  }
}