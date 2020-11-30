output "id" {
  value = module.vpc.vpc_id
}

output "database_subnet_group" {
  value = module.vpc.database_subnet_group
}

output "hvn_cidr_block" {
  value = var.hvn_cidr_block
}