output "id" {
  value = module.vpc.vpc_id
}

output "database_subnet_group" {
  value = module.vpc.database_subnet_group
}

output "hvn_cidr_block" {
  value = var.hvn_cidr_block
}

output "hcp_vault_id" {
  value = module.hcp.hcp_vault_id
}

output "hcp_vault_endpoint" {
  value     = "https://${module.hcp.hcp_vault_public_endpoint}:8200"
  sensitive = true
}

output "hcp_vault_token" {
  value     = hcp_vault_cluster_admin_token.vault.token
  sensitive = true
}