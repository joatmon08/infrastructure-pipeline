resource "vault_github_auth_backend" "org" {
  organization = var.github_organization
}

resource "vault_policy" "team" {
  name = var.resource_group

  policy = <<EOT
path "${var.resource_group}/*" {
  capabilities = ["read", "list"]
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