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

variable "tags" {
  type        = map(string)
  description = "tags to add to resources"
}

variable "private_ssh_key" {
  description = "Base64 encoded contents of private SSH key for Boundary and EKS nodes"
  type        = string
  sensitive   = true
}

variable "client_cidr_block" {
  type        = string
  description = "Client CIDR block"
  sensitive   = true
}