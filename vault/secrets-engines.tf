resource "vault_mount" "pipeline" {
  path        = "infrastructure-pipeline"
  type        = "kv-v2"
  description = "For infrastructure-pipeline static secrets"
}

resource "vault_generic_secret" "pipeline" {
  path = "${vault_mount.pipeline.path}/bootstrap"

  data_json = <<EOT
{
  "db_login":   "admin",
  "db_login_password":   "H@Sh1CoR3!"
}
EOT
}

resource "vault_azure_secret_backend" "azure" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  path            = "${vault_mount.pipeline.path}/azure"
}

resource "vault_azure_secret_backend_role" "pipeline_role" {
  backend = vault_azure_secret_backend.azure.path
  role    = "generated_role"
  ttl     = 300
  max_ttl = 600

  azure_roles {
    role_name = "Contributor"
    scope     = "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.resource_group}"
  }
}