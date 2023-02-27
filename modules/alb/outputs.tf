output "alb_security_group_arn" {
  description = "ALB Security Group ARN"
  value       = aws_security_group.alb_security_group.id
}

output "alb_target_group_arn" {
  description = "ALB Target Group ARN"
  value       = aws_lb_target_group.alb_target_group.id
}

