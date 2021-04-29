output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.db.address
 // sensitive   = true
}



output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.db.port
 // sensitive   = true
}

output "rds_admin_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.db.username
  // sensitive   = true
}

output "rds_admin_password" {
  value = var.db_password
}