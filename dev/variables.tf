# ********************* AWS Settings *********************
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to be used for the project"
  nullable    = false
}

variable "aws_default_vpc" {
  type        = string
  default     = "vpc-0414478a0519fb7fc"
  description = "AWS default VPC created in the region"
  nullable    = false
}

variable "aws_default_subnets" {
  type        = list(string)
  default     = ["subnet-0d5098225a7c8ea96", "subnet-0080b163020cad6e2"]
  description = "AWS default Subnets created in the region for the VPC"
  nullable    = false
}

variable "aws_ecr_arn" {
  type        = string
  default     = "203019893885.dkr.ecr.us-east-1.amazonaws.com/ecr-nbcu"
  description = "AWS ECR ARN"
  nullable    = false
}

variable "aws_ecs_task_roles" {
  type = list(string)
  default = [
    "arn:aws:iam::203019893885:policy/nbcu-cloudwatch-log-write",
    "arn:aws:iam::203019893885:policy/nbcu-ecs-container-policy"
  ]
  description = "AWS ECS Tasks Managed Roles, usually created outside the project"
  nullable    = false
  sensitive   = true
}

variable "aws_ecs_execution_roles" {
  type = list(string)
  default = [
    "arn:aws:iam::203019893885:policy/nbcu-cloudwatch-log-write",
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
  description = "AWS ECS Execution Managed Roles, usually created outside the project"
  nullable    = false
  sensitive   = true
}

variable "aws_s3_bucket" {
  type = string
  default = "tfstates3"
  description = "AWS S3 bucket to store the tfstate file"
  nullable    = false
}

variable "aws_s3_bucket_path" {
  type = string
  default = "tfstates3cejas/nbcu-tfstate-dev/terraform.tfstate"
  description = "AWS S3 bucket path (key) to store the tfstate file"
  nullable    = false
}

# ********************* APP Settings *********************
variable "app_name" {
  type        = string
  default     = "ncbu-website"
  description = "NBCU website lab"
  nullable    = false
}

variable "app_customer" {
  type        = string
  default     = "ncbu"
  description = "NBCU website lab"
  nullable    = false
}

variable "app_owner" {
  type        = string
  default     = "Oscar"
  description = "Owner of the all the resources"
  nullable    = false
}

variable "app_environment" {
  type        = string
  default     = "dev"
  description = "Development environment"
  nullable    = false
}

variable "app_version" {
  type        = string
  default     = "latest"
  description = "Specific version of the app to deploy. Default: latest"
  nullable    = false
}

variable "app_port" {
  type        = number
  default     = 8080
  description = "Port used by the container to run. Default: 8080"
  nullable    = false
}

# ********************* DB Settings *********************
variable "db_username" {
  type        = string
  default     = "root"
  description = "Database username. Default: root"
  nullable    = false
}

variable "db_password" {
  type        = string
  default     = "123456789"
  description = "Database password."
  nullable    = false
  sensitive   = true
}

variable "db_name" {
  type        = string
  default     = "testdb"
  description = "Database name. Default: testdb"
  nullable    = false
  sensitive   = true
}
