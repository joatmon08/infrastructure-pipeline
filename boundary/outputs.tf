output "boundary_auth_method_id" {
  value = boundary_auth_method.password.id
}

output "boundary_operations_password" {
  value     = random_password.operations_team.result
  sensitive = true
}

output "boundary_products_password" {
  value     = random_password.products_team.result
  sensitive = true
}

output "boundary_target_runner" {
  value = boundary_target.runner_ssh.id
}

output "boundary_endpoint" {
  value = local.url
}