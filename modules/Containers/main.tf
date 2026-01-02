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

# resource "aws_ecr_repository" "foo" {
#   name = "l2c-journalapp-repo"
#   image_tag_mutability = "MUTABLE"
# }

resource "aws_ecs_cluster" "cluster" {
  name = "l2c-ecs-cluster"
}

resource "aws_ecs_service" "journal-app" {
    name = "fastAPI-journal-app"
    cluster = aws_ecs_cluster.cluster.id
    task_definition = aws_ecs_task_definition.fastAPI-app.arn
    desired_count = 1
    launch_type = "FARGATE"

    network_configuration {
      subnets = var.subnets
      security_groups = var.security_groups
      assign_public_ip = true
    }
}

resource "aws_ecs_task_definition" "fastAPI-app" {
  family = "fastAPI-app"
  requires_compatibilities = [ "FARGATE" ]
  container_definitions = jsonencode([
    {
        name = "l2c-journalApp"
        image = "${var.container_image}"
        cpu = 512
        memory = 1024
        essential = true
        portMappings = [
            {
            containerPort = 8000
            hostPort = 8000
        }

        ]
    }
  ])

  runtime_platform {
    cpu_architecture = "X86_64"
  }
}