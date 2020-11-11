variable "resource_group" {
  type        = string
  description = "existing Azure resource group"
}

variable "name" {
  type        = string
  description = "name of PostgreSQL database"
}

variable "db_username" {
  type        = string
  description = "username for PostgreSQL database"
}

variable "db_password" {
  type        = string
  description = "password for PostgreSQL database"
}

variable "vault_ip_address" {
  type        = string
  description = "IP address of Vault to allow connection to database"
}
