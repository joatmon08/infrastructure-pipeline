terraform {
  required_version = "~>0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.16.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.15.0"
    }
  }
  backend "remote" {}
}

provider "aws" {
  region = var.region
}

provider "vault" {}