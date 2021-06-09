variable "aws_access_key_id" {
  type      = string
  sensitive = true
}

variable "aws_secret_access_key" {
  type      = string
  sensitive = true
}

variable "aws_role_arns" {
  type = list(string)
}

variable "terraform_cloud_token" {
  type      = string
  sensitive = true
}

variable "terraform_cloud_organization" {
  type = string
}

variable "terraform_cloud_infrastructure_workspace" {
  type = string
}
variable "terraform_cloud_team_id" {
  type      = string
  sensitive = true
}

variable "vault_namespace" {
  type    = string
  default = "admin"
}

variable "pipeline_name" {
  type        = string
  description = "Name of pipeline for Vault AppRole"
  default     = "infrastructure-pipeline"
}

locals {
  region     = data.terraform_remote_state.infrastructure.outputs.region
  ami_id     = data.terraform_remote_state.infrastructure.outputs.runner_ami_id
  subnet_id  = data.terraform_remote_state.infrastructure.outputs.runner_subnet_id
  cidr_block = data.terraform_remote_state.infrastructure.outputs.vpc_cidr_block
}