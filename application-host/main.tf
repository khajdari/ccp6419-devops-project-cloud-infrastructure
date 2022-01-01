provider "azurerm" {
  features {}
  version = "=2.37.0"

  subscription_id             = var.subscription_id
  client_id                   = var.client_id
  client_certificate_path     = var.client_certificate_pass
  client_certificate_password = var.client_certificate_password
  tenant_id                   = var.tenant_id
}

# create a resource group
resource "azurerm_resource_group" "ccp6419-application-host" {
  name     = "ccp6419-application-host"
  location = var.location
}