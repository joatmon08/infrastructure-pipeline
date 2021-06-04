resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_policy" "pipeline" {
  name = var.pipeline_name

  policy = <<EOT
path "${var.pipeline_name}/*" {
  capabilities = ["read"]
}

path "auth/token/create" {
    capabilities = ["update"]
}

path "${vault_mount.database.path}/*" {
  capabilities = ["create", "read", "update", "delete"]
}
EOT
}

resource "vault_approle_auth_backend_role" "pipeline" {
  backend            = vault_auth_backend.approle.path
  role_name          = var.pipeline_name
  role_id            = var.pipeline_name
  secret_id_ttl      = 86400
  secret_id_num_uses = 0
  token_ttl          = 14400
  token_max_ttl      = 86400
  token_policies = [
    vault_policy.pipeline.name
  ]
}