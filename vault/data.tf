data "terraform_remote_state" "infrastructure" {
  backend = "remote"

  config = {
    organization = var.terraform_cloud_organization
    workspaces = {
      name = var.terraform_cloud_infrastructure_workspace
    }
  }
}