# ccp6419-database-host instance
resource "azurerm_virtual_machine" "ccp6419-database-host-instance" {
  name                             = "${var.prefix}-vm"
  location                         = var.location
  resource_group_name              = azurerm_resource_group.ccp6419-database-host.name
  network_interface_ids            = [azurerm_network_interface.ccp6419-database-host-instance.id]
  vm_size                          = "Standard_A1_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.prefix}-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.prefix}-os-profile"
    admin_username = "khajdari"
    admin_password = "athtech"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("ccp6419-azure-key.pub")
      path     = "/home/khajdari/.ssh/authorized_keys"
    }
  }
}

resource "azurerm_network_interface" "ccp6419-database-host-instance" {
  name                = "${var.prefix}-instance"
  location            = var.location
  resource_group_name = azurerm_resource_group.ccp6419-database-host.name

  ip_configuration {
    name                          = "instance"
    subnet_id                     = azurerm_subnet.ccp6419-database-host-internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ccp6419-database-host-instance.id
  }
}

resource "azurerm_network_interface_security_group_association" "allow-ssh" {
  network_interface_id      = azurerm_network_interface.ccp6419-database-host-instance.id
  network_security_group_id = azurerm_network_security_group.allow-ports.id
}

resource "azurerm_public_ip" "ccp6419-database-host-instance" {
  name                = "${var.prefix}-instance-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.ccp6419-database-host.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_machine_extension" "ccp6419-database-host-extension" {
  name                 = "${var.prefix}-os-profile"
  virtual_machine_id   = azurerm_virtual_machine.ccp6419-database-host-instance.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${filebase64("ccp6419-database-host-setup.sh")}"
    }
SETTINGS

  tags = {
    environment = "Production"
  }
}