resource "vault_database_secret_backend_connection" "postgres" {
  backend       = "${var.pipeline_name}/database"
  name          = "postgres"
  allowed_roles = ["application"]

  postgresql {
    connection_url = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.example.endpoint}/${aws_db_instance.example.name}"
  }

  depends_on = [aws_db_instance.example]
}

resource "vault_database_secret_backend_role" "role" {
  backend             = "${var.pipeline_name}/database"
  name                = "application"
  db_name             = vault_database_secret_backend_connection.postgres.name
  creation_statements = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"]
}