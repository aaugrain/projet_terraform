#créer un NSG
resource "azurerm_subnet" "Subnet2" {
    name = "Subnet2"
    resource_group_name = "${var.name}"
    virtual_network_name = "${var.name_vnet}"
    address_prefix = "10.0.2.0/24"
}
resource "azurerm_network_security_group" "NSG2" {
  name                = "NSG2"
  location            = "${var.location}"
  resource_group_name = "${var.name}"

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "APP"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface" "NetI2" {
  name                = "NetI2"
  location            = "${var.location}"
  resource_group_name = "${var.name}"
  network_security_group_id = "${azurerm_network_security_group.NSG2.id}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${azurerm_subnet.Subnet2.id}"
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.2.4"
  }
}
resource "azurerm_virtual_machine" "vm2" {
  name                  = "vm2"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.NetI2.id}"]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "Openlogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }
  storage_os_disk {
    name              = "mydisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_data_disk {
    name              = "datadisk2"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "512"
  }
  os_profile {
    computer_name  = "node"
    admin_username = "vagrant"
    admin_password = "cangetin"
  }
  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
        path="/home/vagrant/.ssh/authorized_keys"
        key_data = "${var.key_data}"
    }
  }
}
