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
