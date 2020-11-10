resource "vault_mount" "pipeline" {
  path        = "${var.resource_group}/static"
  type        = "kv-v2"
  description = "For ${var.resource_group} static secrets"
}

resource "vault_generic_secret" "azure" {
  path = "${vault_mount.pipeline.path}/azure"

  data_json = <<EOT
{
  "subscription_id": "${var.azure_subscription_id}",
  "tenant_id": "${var.azure_tenant_id}"
}
EOT
}

resource "vault_generic_secret" "database" {
  path = "${vault_mount.pipeline.path}/database"

  data_json = <<EOT
{
  "db_login": "admin",
  "db_login_password": "H@Sh1CoR3!"
}
EOT
}

resource "vault_azure_secret_backend" "azure" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  path            = "${var.resource_group}/azure"
}

resource "vault_azure_secret_backend_role" "pipeline" {
  backend = vault_azure_secret_backend.azure.path
  role    = "pipeline"
  ttl     = 300
  max_ttl = 600

  azure_roles {
    role_name = "Contributor"
    scope     = "/subscriptions/${var.azure_subscription_id}/resourceGroups/${azurerm_resource_group.team.name}"
  }
}