terraform {
  required_version = "~>0.13"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.15.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.35.0"
    }
  }
  backend "remote" {}
}

provider "vault" {}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  features {}
}