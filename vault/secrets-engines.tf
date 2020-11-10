resource "vault_mount" "pipeline" {
  path        = "infrastructure-pipeline"
  type        = "kv-v2"
  description = "For infrastructure-pipeline static secrets"
}

resource "vault_generic_secret" "pipeline" {
  path = vault_mount.pipeline.path

  data_json = <<EOT
{
  "db_login":   "admin",
  "db_login_password":   "H@Sh1CoR3!"
}
EOT
}