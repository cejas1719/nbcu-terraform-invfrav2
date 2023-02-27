resource "aws_security_group" "alb_security_group" {
  name        = "${var.app_customer}-${var.app_name}-sg-${var.app_environment}"
  description = "ALB Security Group"
  vpc_id      = var.aws_vpc

  ingress {
    description = "Public access for HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App port access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Go everywhere"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "app_customer"    = var.app_customer
    "app_name"        = var.app_name
    "app_environment" = var.app_environment
    "app_owner"       = var.app_owner
  }
}

resource "aws_lb" "alb" {
  name               = "${var.app_customer}-${var.app_name}-alb-${var.app_environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = var.aws_subnets

  tags = {
    "app_customer"    = var.app_customer
    "app_name"        = var.app_name
    "app_environment" = var.app_environment
    "app_owner"       = var.app_owner
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name        = "${var.app_customer}-${var.app_name}-alb-tg-${var.app_environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.aws_vpc
  target_type = "ip"
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
