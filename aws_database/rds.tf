resource "aws_db_subnet_group" "web" {
  name = "db-for-wp"
  subnet_ids = var.subnet_ids
}
output "db_subnet" {
  value = aws_db_subnet_group.web
}
resource "aws_db_instance" "db" {
  identifier = "db"
  instance_class = "db.t2.micro"
  allocated_storage = 5
  engine = "mysql"
  username = "admin"
  password = var.db_password
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.web.id
  vpc_security_group_ids = [ var.security_group_id ]
}