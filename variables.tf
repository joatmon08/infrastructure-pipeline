variable "environment" {
  type        = string
  description = "environment for resources"
}

variable "pipeline_name" {
  type        = string
  description = "name of infrastructure pipeline"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "db_username" {
  type        = string
  description = "username for PostgreSQL database"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "password for PostgreSQL database"
  sensitive   = true
}

variable "vault_network_address" {
  type        = string
  description = "network IP address range for Vault"
}

locals {
  name = "${var.environment}-${var.pipeline_name}"
}