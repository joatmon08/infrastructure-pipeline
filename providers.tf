terraform {
  required_version = "~>0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.35.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.15.0"
    }
  }
  backend "remote" {}
}

provider "azurerm" {
  features {}
}

provider "vault" {}