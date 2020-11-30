variable "name" {
  type        = string
  description = "name of network"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "hvn_cidr_block" {
  type        = string
  description = "IP address range of Vault to allow connection to database"
}

variable "peering_connection_has_been_added_to_hvn" {
  type        = bool
  description = "if connection has been added to hvn"
  default     = false
}