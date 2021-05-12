output "public_ip_ranges" {
  value = var.public_subnet_ranges
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_public_ids" {
  value = aws_subnet.public[*].id
}

output "subnet_private_ids" {
  value = aws_subnet.private[*].id
}

output "http_security_group_id" {
  value = aws_security_group.allow_http.id
}

output "lb_dns_name" {
  value = aws_lb.alb.dns_name
}




