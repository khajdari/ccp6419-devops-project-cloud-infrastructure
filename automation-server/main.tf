provider "azurerm" {
  features {}
  version = "=2.46.0"
}

# create a resource group
resource "azurerm_resource_group" "ccp6419-automation-server" {
  name     = "ccp6419-automation-server"
  location = var.location
}