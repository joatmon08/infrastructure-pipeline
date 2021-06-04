terraform {
  required_version = ">=0.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.44"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.6"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "hcp" {}