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