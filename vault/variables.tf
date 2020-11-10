variable "github_team" {
  type        = string
  description = "Github team that should have read role"
}

variable "github_organization" {
  type        = string
  description = "Github organization"
}

variable "azure_subscription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_client_id" {
  type = string
}

variable "azure_client_secret" {
  type = string
}

variable "terraform_cloud_token" {
  type = string
}

variable "resource_group" {
  type        = string
  description = "Azure resource group that Terraform can create resources"
  default     = "infrastructure-pipeline"
}

variable "location" {
  type        = string
  description = "Azure location"
  default     = "West US"
}