provider "azurerm" {
  features {}
  version = "=2.37.0"
}

# create a resource group
resource "azurerm_resource_group" "ccp6419-database-host" {
  name     = "ccp6419-database-host"
  location = var.location
}