provider "aws" {
  region = var.aws_region
}

module "app_ecs_cluster" {
  source = "../modules/ecs_cluster"

  app_name        = var.app_name
  app_customer    = var.app_customer
  app_owner       = var.app_owner
  app_environment = var.app_environment
}

module "app_alb" {
  source = "../modules/alb"

  app_name        = var.app_name
  app_customer    = var.app_customer
  app_owner       = var.app_owner
  app_environment = var.app_environment

  aws_vpc     = var.aws_default_vpc
  aws_subnets = var.aws_default_subnets
}

module "app_db" {
  source = "../modules/rds"

  app_name        = var.app_name
  app_customer    = var.app_customer
  app_owner       = var.app_owner
  app_environment = var.app_environment

  aws_subnets = var.aws_default_subnets

  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name
}

module "app_ecs_details" {
  source = "../modules/ecs_app"

  app_name        = var.app_name
  app_customer    = var.app_customer
  app_owner       = var.app_owner
  app_environment = var.app_environment
  app_version     = var.app_version

  aws_ecr_arn             = var.aws_ecr_arn
  aws_ecs_execution_roles = var.aws_ecs_execution_roles
  aws_ecs_task_roles      = var.aws_ecs_task_roles
  aws_default_subnets     = var.aws_default_subnets

  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name

  ecs_cluster_arn        = module.app_ecs_cluster.ecs_cluster_arn
  alb_security_group_arn = module.app_alb.alb_security_group_arn
  alb_target_group_arn   = module.app_alb.alb_target_group_arn
  db_endpoint_url        = module.app_db.db_endpoint_url

  depends_on = [
    module.app_ecs_cluster,
    module.app_alb,
    module.app_db
  ]
}

# Set the S3 bucket to store tfstate file 
terraform {
  backend "s3" {
    bucket              = "tfstates3"
    key                 = "cejas/nbcu-tfstate-dev/terraform.tfstate"
  }
}