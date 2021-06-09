resource "boundary_target" "runner_ssh" {
  type                     = "tcp"
  name                     = "runner_ssh"
  description              = "Runner SSH target"
  scope_id                 = boundary_scope.core_infra.id
  session_connection_limit = -1
  default_port             = 22
  host_set_ids = [
    boundary_host_set.runner.id
  ]
}