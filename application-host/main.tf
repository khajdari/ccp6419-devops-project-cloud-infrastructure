provider "azurerm" {
  features {}
  version = "=2.37.0"

  subscription_id = "01c3b346-bca0-4aca-9098-835267f0e8aa"
  tenant_id       = "979c83c1-112c-4add-812a-d3ea1a9e2886"
}

# create a resource group
resource "azurerm_resource_group" "ccp6419-application-host" {
  name     = "ccp6419-application-host"
  location = var.location
}