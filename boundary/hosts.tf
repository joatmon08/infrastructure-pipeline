resource "boundary_host_catalog" "runner" {
  name        = "runner"
  description = "Runner for CI Frameworks"
  type        = "static"
  scope_id    = boundary_scope.core_infra.id
}

resource "boundary_host" "runner" {
  for_each        = local.runner_target_ips
  type            = "static"
  name            = "runner_${each.value}"
  description     = "Runner #${each.value}"
  address         = each.key
  host_catalog_id = boundary_host_catalog.runner.id
}

resource "boundary_host_set" "runner" {
  type            = "static"
  name            = "runner"
  description     = "Host set for runners"
  host_catalog_id = boundary_host_catalog.runner.id
  host_ids        = [for host in boundary_host.runner : host.id]
}
