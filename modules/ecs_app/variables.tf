# ********************* APP Settings *********************
variable "app_name" {
  type        = string
  description = "NBCU website lab"
  nullable    = false
}

variable "app_customer" {
  type        = string
  description = "NBCU website lab"
  nullable    = false
}

variable "app_owner" {
  type        = string
  description = "Owner of the all the resources"
  nullable    = false
}

variable "app_environment" {
  type        = string
  description = "Development environment"
  nullable    = false
}

variable "app_version" {
  type        = string
  description = "Specific version of the app to deploy. Default: latest"
  nullable    = false
}

variable "app_port" {
  type        = number
  default     = 8080
  description = "Port used by the container to run. Default: 8080"
  nullable    = false
}

# ********************* External Modules *********************
variable "ecs_cluster_arn" {
  type        = string
  description = "ECS Cluster ARN/ID"
  nullable    = false
  sensitive   = true
}

variable "alb_security_group_arn" {
  type        = string
  description = "ALB Security Group ARN/ID"
  nullable    = false
  sensitive   = true
}

variable "alb_target_group_arn" {
  type        = string
  description = "ALB Target Group ARN/ID"
  nullable    = false
  sensitive   = true
}

variable "db_endpoint_url" {
  type        = string
  description = "RDS database endpoint URL"
  nullable    = false
}

# ********************* AWS Settings *********************
variable "aws_ecr_arn" {
  type        = string
  description = "AWS ECR ARN"
  nullable    = false
}

variable "aws_ecs_task_roles" {
  type        = list(string)
  description = "AWS ECS Tasks Managed Roles, usually created outside the project"
  nullable    = false
  sensitive   = true
}

variable "aws_ecs_execution_roles" {
  type        = list(string)
  description = "AWS ECS Execution Managed Roles, usually created outside the project"
  nullable    = false
  sensitive   = true
}

variable "aws_default_subnets" {
  type        = list(string)
  description = "AWS default Subnets created in the region for the VPC"
  nullable    = false
}

# ********************* DB Settings *********************
variable "db_username" {
  type        = string
  description = "Database username. Default: root"
  nullable    = false
}

variable "db_password" {
  type        = string
  description = "Database password."
  nullable    = false
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "Database name. Default: testdb"
  nullable    = false
  sensitive   = true
}
