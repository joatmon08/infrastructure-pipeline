resource "vault_github_auth_backend" "org" {
  organization = var.github_organization
}

resource "vault_policy" "team" {
  name = "${var.resource_group}-team"

  policy = <<EOT
path "auth/approle/role/${var.resource_group}/secret-id" {
  capabilities = ["create", "update"]
}

path "sys/leases/lookup/*" {
  capabilities = ["list", "read", "sudo"]
}

path "${var.resource_group}/*" {
  capabilities = ["list", "read"]
}
EOT
}

resource "vault_github_team" "team" {
  backend = vault_github_auth_backend.org.id
  team    = var.github_team
  policies = [
    vault_policy.team.name
  ]
}

resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_policy" "pipeline" {
  name = var.resource_group

  policy = <<EOT
path "${var.resource_group}/*" {
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