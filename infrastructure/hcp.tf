locals {
  route_table_ids = concat(module.vpc.private_route_table_ids, module.vpc.public_route_table_ids)
}

module "hcp" {
  source                    = "joatmon08/hcp/aws"
  version                   = "1.0.0"
  hvn_region                = var.region
  hvn_name                  = var.name
  hvn_cidr_block            = var.hvn_cidr_block
  vpc_id                    = module.vpc.vpc_id
  vpc_owner_id              = module.vpc.vpc_owner_id
  vpc_cidr_block            = module.vpc.vpc_cidr_block
  route_table_ids           = local.route_table_ids
  number_of_route_table_ids = length(local.route_table_ids)
  tags                      = var.tags
  hcp_vault_name            = var.name
  hcp_vault_public_endpoint = true
}

resource "hcp_vault_cluster_admin_token" "vault" {
  cluster_id = module.hcp.hcp_vault_id
}