data "aws_rds_engine_version" "example" {
  engine = "postgres"
}
data "aws_db_subnet_group" "database" {
  name = local.name
}
resource "aws_db_instance" "example" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = data.aws_rds_engine_version.example.version
  instance_class       = "db.t2.micro"
  name                 = var.environment
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = data.aws_db_subnet_group.database.name
  skip_final_snapshot  = true
}