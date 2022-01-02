provider "azurerm" {
  features {}
  version = "=2.46.0"
}

# create a resource group for the configuration manager server
resource "azurerm_resource_group" "ccp6419-configuration-server" {
  name     = "ccp6419-configuration-server"
  location = var.location
}