resource "aws_cloudwatch_log_group" "example" {
  name = "ecs-demo"
}

resource "aws_kms_key" "example" {
  description             = "ecs-demo"
  deletion_window_in_days = 7
}

resource "aws_ecs_cluster" "test" {
  name = var.name_prefix

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.example.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.example.name
      }
    }
  }
}

resource "aws_ecs_task_definition" "test" {
  family                   = "nginx"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn 
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn 
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = file(var.container_definition)

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "nginx" {

  name            = "nginx"
  cluster         = "demo-terraform"
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.test.arn
  desired_count   = 1

  load_balancer {  
    target_group_arn = var.target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }
    network_configuration {
        subnets = var.subnets
    }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name                 = "${var.name_prefix}-ecs-task-execution-role"
  assume_role_policy   = file("policy.json")
}