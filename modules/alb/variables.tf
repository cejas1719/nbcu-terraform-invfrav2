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
variable "aws_vpc" {
  type        = string
  description = "AWS VPC ARN"
  nullable    = false
}

variable "aws_subnets" {
  type        = list(string)
  description = "AWS default Subnets created in the region for the VPC"
  nullable    = false
}
