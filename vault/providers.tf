terraform {
  required_version = "~>0.15"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.20"
    }
  }
}

provider "vault" {
  address   = data.terraform_remote_state.infrastructure.outputs.hcp_vault_endpoint
  token     = data.terraform_remote_state.infrastructure.outputs.hcp_vault_token
  namespace = var.vault_namespace
}