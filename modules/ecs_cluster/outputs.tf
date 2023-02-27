output "ecs_cluster_arn" {
  description = "The ID of the ECS CLuster"
  value       = aws_ecs_cluster.nbcu_website_ecs.id
}
