module "hcp" {
  count                     = var.peering_connection_has_been_added_to_hvn ? 1 : 0
  source                    = "joatmon08/hcp/aws"
  version                   = "0.2.0"
  hvn_cidr_block            = var.hvn_cidr_block
  route_table_ids           = module.vpc.database_route_table_ids
  number_of_route_table_ids = 1
  vpc_id                    = module.vpc.vpc_id
}