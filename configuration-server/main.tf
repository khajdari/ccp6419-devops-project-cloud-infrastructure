provider "azurerm" {
  features {}
  version = "=2.37.0"
}

# create a resource group
resource "azurerm_resource_group" "ccp6419-configuration-server" {
  name     = "ccp6419-configuration-server"
  location = var.location
}