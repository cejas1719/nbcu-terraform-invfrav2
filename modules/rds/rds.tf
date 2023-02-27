#create subnet group
resource "aws_db_subnet_group" "nbcu_website_mysql_subnet" {
  name       = "${var.app_customer}-${var.app_name}-db-sg-${var.app_environment}"
  subnet_ids = var.aws_subnets


  tags = {
    "app_customer"    = var.app_customer
    "app_name"        = var.app_name
    "app_environment" = var.app_environment
    "app_owner"       = var.app_owner
  }
}

# Create MySQL BD 
resource "aws_db_instance" "nbcu_website_mysql" {
  allocated_storage   = 10
  db_name             = var.db_name
  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = "db.t3.micro"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true

  # Asociate DB created to a private subnet
  db_subnet_group_name = aws_db_subnet_group.nbcu_website_mysql_subnet.name

  tags = {
    "app_customer"    = var.app_customer
    "app_name"        = var.app_name
    "app_environment" = var.app_environment
    "app_owner"       = var.app_owner
  }
}
