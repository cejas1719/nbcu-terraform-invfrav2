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

# ********************* AWS Settings *********************
variable "aws_subnets" {
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
