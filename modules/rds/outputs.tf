output "db_endpoint_url" {
  description = "Database endpoint URL"
  value       = aws_db_instance.nbcu_website_mysql.endpoint
}