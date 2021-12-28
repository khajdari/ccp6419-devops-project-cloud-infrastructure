resource "azurerm_virtual_network" "ccp6419-application-host" {
  name                = "${var.prefix}-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.ccp6419-application-host.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "ccp6419-application-host-internal" {
  name                 = "${var.prefix}-internal"
  resource_group_name  = azurerm_resource_group.ccp6419-application-host.name
  virtual_network_name = azurerm_virtual_network.ccp6419-application-host.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "allow-ports" {
  name                = "${var.prefix}-allow-ssh"
  location            = var.location
  resource_group_name = azurerm_resource_group.ccp6419-application-host.name

  security_rule {
    name                       = "ssh"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh-source-address
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = var.http-source-address
    destination_address_prefix = "*"
  }
}