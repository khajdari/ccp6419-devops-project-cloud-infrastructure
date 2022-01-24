provider "azurerm" {
  features {}
  version = "=2.46.0"
}

# create a resource group for application host
resource "azurerm_resource_group" "ccp6419-application-host" {
  name     = "ccp6419-application-host"
  location = var.location
}