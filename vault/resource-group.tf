resource "azurerm_resource_group" "team" {
  name     = var.resource_group
  location = var.location
}