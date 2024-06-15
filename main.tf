# tfresourcegroup1.tf

resource "azurerm_resource_group" "tfresourcegroup1" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "tfresourcegroup1" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.tfresourcegroup1.name
}

resource "azurerm_subnet" "tfresourcegroup1" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.tfresourcegroup1.name
  virtual_network_name = azurerm_virtual_network.tfresourcegroup1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "tfresourcegroup1" {
  name                = "myNIC"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfresourcegroup1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tfresourcegroup1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "tfresourcegroup1" {
  name                = "myNSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfresourcegroup1.name
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "SSH"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.tfresourcegroup1.name
  network_security_group_name = azurerm_network_security_group.tfresourcegroup1.name
}

resource "azurerm_public_ip" "tfresourcegroup1" {
  name                = "myPublicIP"
  location            = var.location
  resource_group_name = azurerm_resource_group.tfresourcegroup1.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface_security_group_association" "tfresourcegroup1" {
  network_interface_id      = azurerm_network_interface.tfresourcegroup1.id
  network_security_group_id = azurerm_network_security_group.tfresourcegroup1.id
}

resource "azurerm_linux_virtual_machine" "tfresourcegroup1" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.tfresourcegroup1.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.tfresourcegroup1.id]

  os_disk {
    name              = "${var.vm_name}_os_disk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

output "admin_username" {
  value = var.admin_username
}

output "admin_password" {
  value     = var.admin_password
  sensitive = true
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.tfresourcegroup1.public_ip_address
}