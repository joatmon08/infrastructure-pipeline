resource "vault_database_secret_backend_connection" "postgres" {
  backend       = "${var.resource_group}/database"
  name          = "postgres"
  allowed_roles = [var.resource_group]

  postgresql {
    connection_url = "postgres://${var.db_username}:${var.db_password}@${azurerm_postgresql_server.example.fqdn}:5432/${azurerm_postgresql_database.example.name}"
  }
}

resource "vault_database_secret_backend_role" "role" {
  backend             = "${var.resource_group}/database"
  name                = "application"
  db_name             = vault_database_secret_backend_connection.postgres.name
  creation_statements = "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"
}