provider "azurerm" {
  features {}
  version = "=2.46.0"
}

# create a resource group for the configuration server
resource "azurerm_resource_group" "ccp6419-configuration-server" {
  name     = "ccp6419-configuration-server"
  location = var.location
}