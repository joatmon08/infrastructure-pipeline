// Static Passwords at key-value store

resource "vault_mount" "pipeline" {
  path        = "${var.pipeline_name}/static"
  type        = "kv-v2"
  description = "For ${var.pipeline_name} static secrets"
}

// Generate Terraform Cloud token

resource "vault_terraform_cloud_secret_backend" "tfc" {
  backend     = "terraform"
  description = "Manages the Terraform Cloud backend"
  token       = var.terraform_cloud_token
}

resource "vault_terraform_cloud_secret_role" "tfc" {
  backend      = vault_terraform_cloud_secret_backend.tfc.backend
  name         = "terraform-cloud"
  organization = var.terraform_cloud_organization
  team_id      = var.terraform_cloud_team_id
}

resource "vault_terraform_cloud_secret_creds" "tfc" {
  backend = vault_terraform_cloud_secret_backend.tfc.backend
  role    = vault_terraform_cloud_secret_role.tfc.name
}

resource "random_password" "password" {
  length           = 12
  special          = true
  override_special = "!&$"
}

resource "vault_generic_secret" "database" {
  path = "${vault_mount.pipeline.path}/database"

  data_json = <<EOT
{
  "db_login": "hcpvault",
  "db_login_password": "${random_password.password.result}"
}
EOT
}

// Database secrets engine for PostgreSQL

resource "vault_mount" "database" {
  path = "${var.pipeline_name}/database"
  type = "database"
}

// AWS Secrets Engine

resource "vault_aws_secret_backend" "aws" {
  path       = "${var.pipeline_name}/aws"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

resource "vault_aws_secret_backend_role" "role" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "pipeline"
  credential_type = "assumed_role"
  role_arns       = var.aws_role_arns
  default_sts_ttl = 1800
  max_sts_ttl     = 3600
}