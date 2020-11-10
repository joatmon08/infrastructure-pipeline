terraform {
  required_version = "~>0.13"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.15.0"
    }
  }
  backend "remote" {}
}

provider "vault" {}