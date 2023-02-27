resource "aws_iam_role" "nbcu_website_execution_role" {
  name                = "${var.app_customer}-${var.app_name}-ecs-execution-role-${var.app_environment}"
  managed_policy_arns = var.aws_ecs_execution_roles

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })

  tags = {
    "app_customer"    = var.app_customer
    "app_name"        = var.app_name
    "app_environment" = var.app_environment
    "app_owner"       = var.app_owner
  }
}

resource "aws_iam_role" "nbcu_website_task_role" {
  name                = "${var.app_customer}-${var.app_name}-ecs-task-role-${var.app_environment}"
  managed_policy_arns = var.aws_ecs_task_roles

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })

  tags = {
    "app_customer"    = var.app_customer
    "app_name"        = var.app_name
    "app_environment" = var.app_environment
    "app_owner"       = var.app_owner
  }
}


resource "aws_ecs_task_definition" "nbcu_website_task" {
  family                   = "${var.app_customer}-${var.app_name}-ecs-task-${var.app_environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.nbcu_website_execution_role.arn
  task_role_arn            = aws_iam_role.nbcu_website_task_role.arn
  container_definitions = jsonencode([{
    name = "${var.app_customer}-${var.app_name}-container-${var.app_environment}"
    #TODO: tag must be dynamic/input
    image     = "${var.aws_ecr_arn}:${var.app_version}"
    essential = true
    environment = [
      { "name" : "NODE_ENV", "value" : "${var.app_environment}" },
      { "name" : "DB_HOST", "value" : "${var.db_endpoint_url}" },
      { "name" : "DB_USERNAME", "value" : "${var.db_username}" },
      { "name" : "DB_PASSWORD", "value" : "${var.db_password}" },
      { "name" : "DB_NAME", "value" : "${var.db_name}" }
    ]
    portMappings = [{
      protocol      = "tcp"
      containerPort = var.app_port
      hostPort      = var.app_port
    }]
    working_directory = "/app"
    command = [
      "node", "server.js"
    ]
  }])

  tags = {
    "app_customer"    = var.app_customer
    "app_name"        = var.app_name
    "app_environment" = var.app_environment
    "app_owner"       = var.app_owner
  }
}

resource "aws_ecs_service" "nbcu_website_service" {
  name            = "${var.app_customer}-${var.app_name}-ecs-service-${var.app_environment}"
  cluster         = var.ecs_cluster_arn
  task_definition = aws_ecs_task_definition.nbcu_website_task.id
  #TODO: can be a global variable since dev/prod config might be different
  desired_count                      = 1
  launch_type                        = "FARGATE"
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  network_configuration {
    security_groups  = [var.alb_security_group_arn]
    subnets          = var.aws_default_subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "${var.app_customer}-${var.app_name}-container-${var.app_environment}"
    container_port   = var.app_port
  }


}
