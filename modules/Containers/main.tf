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

resource "aws_ecs_cluster" "cluster" {
  name = "l2c-ecs-cluster"
}

resource "aws_ecs_service" "journal-app" {
    name = "fastAPI-journal-app"
    cluster = aws_ecs_cluster.cluster.id
    task_definition = aws_ecs_task_definition.fastAPI-app.arn
    desired_count = 1
    launch_type = "FARGATE"
    enable_execute_command = true

    network_configuration {
      subnets = var.subnets
      security_groups = var.security_groups
      assign_public_ip = true
    }
}

resource "aws_ecs_task_definition" "fastAPI-app" {
  family = "fastAPI-app"
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  cpu = 512
  memory = 1024
  execution_role_arn = var.execution_role
  task_role_arn = var.task_role
  container_definitions = jsonencode([
    {
        name = "l2c-journalApp"
        image = "${var.container_image}"
        secret = [
          {
            name = "POSTGRES_USER"
            valueFrom = var.db_username
          },
          {
            name = "POSTGRES_PASSWORD"
            valueFrom = var.db_password
          }
        ]
        environment = [
            {
                name = "POSTGRES_DB"
                value = var.db_name
            },
            {
                name = "DATABASE_URL"
                value = var.db_url
            }
        ]
        cpu = 512
        memory = 1024
        essential = true
        portMappings = [
            {
            containerPort = 8000
            hostPort = 8000
            protocol = "tcp"
        }

        ]
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            "awslogs-group" = var.log_group
            "awslogs-region" = var.aws_region
            "awslogs-stream-prefix" = "ecs"
          }
        }
    }
  ])

  runtime_platform {
    cpu_architecture = "ARM64"
  }
}