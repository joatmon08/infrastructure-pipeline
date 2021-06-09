variable "tfc_organization" {
  type        = string
  description = "TFC Organization for remote state of infrastructure"
}

variable "tfc_workspace" {
  type        = string
  description = "TFC Organization for remote state of infrastructure"
}

data "terraform_remote_state" "infrastructure" {
  backend = "remote"

  config = {
    organization = var.tfc_organization
    workspaces = {
      name = var.tfc_workspace
    }
  }
}

variable "operations_team" {
  type = set(string)
  default = [
    "rosemary"
  ]
}

variable "products_team" {
  type = set(string)
  default = [
    "rob"
  ]
}

variable "leadership_team" {
  type = set(string)
  default = [
    "melissa"
  ]
}

data "aws_instances" "runner" {
  instance_tags = {
    "Name" = "runner"
  }
}

locals {
  region              = data.terraform_remote_state.infrastructure.outputs.region
  url                 = data.terraform_remote_state.infrastructure.outputs.boundary_endpoint
  kms_recovery_key_id = data.terraform_remote_state.infrastructure.outputs.boundary_kms_recovery_key_id
  runner_target_ips   = toset(data.aws_instances.runner.private_ips)
}