resource "aws_ecs_cluster" "nbcu_website_ecs" {
  name                = "${var.app_customer}-${var.app_name}-ecs-${var.app_environment}"

  tags = {
    "app_customer"    = var.app_customer
    "app_name"        = var.app_name
    "app_environment" = var.app_environment
    "app_owner"       = var.app_owner
  }
}
