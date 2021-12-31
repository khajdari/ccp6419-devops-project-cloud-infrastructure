resource "azurerm_virtual_network" "ccp6419-automation-server" {
  name                = "${var.prefix}-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.ccp6419-automation-server.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "ccp6419-automation-server-internal" {
  name                 = "${var.prefix}-internal"
  resource_group_name  = azurerm_resource_group.ccp6419-automation-server.name
  virtual_network_name = azurerm_virtual_network.ccp6419-automation-server.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "allow-ports" {
  name                = "${var.prefix}-allow-ports"
  location            = var.location
  resource_group_name = azurerm_resource_group.ccp6419-automation-server.name

  security_rule {
    name                       = "ssh"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = var.full-range
    destination_port_range     = "22"
    source_address_prefix      = var.full-range
    destination_address_prefix = var.full-range
  }

  security_rule {
    name                       = "http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = var.full-range
    destination_port_range     = "8080"
    source_address_prefix      = var.full-range
    destination_address_prefix = var.full-range
  }

  security_rule {
    name                       = "icmp"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = var.full-range
    destination_port_range     = var.full-range
    source_address_prefix      = var.full-range
    destination_address_prefix = var.full-range
  }
}