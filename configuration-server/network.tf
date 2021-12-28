resource "azurerm_virtual_network" "ccp6419-configuration-server" {
  name                = "${var.prefix}-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.ccp6419-configuration-server.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "ccp6419-configuration-server-internal" {
  name                 = "${var.prefix}-internal"
  resource_group_name  = azurerm_resource_group.ccp6419-configuration-server.name
  virtual_network_name = azurerm_virtual_network.ccp6419-configuration-server.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "allow-ssh" {
  name                = "${var.prefix}-allow-ssh"
  location            = var.location
  resource_group_name = azurerm_resource_group.ccp6419-configuration-server.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh-source-address
    destination_address_prefix = "*"
  }
}