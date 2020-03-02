resource "azurerm_public_ip" "publicIP1" {
  name                = "PublicIP1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method   = "Dynamic"
  domain_name_label = "dnsyl20"
}
#créer un NSG
resource "azurerm_network_security_group" "NSG1" {
  name                = "NSG1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

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
    name                       = "JENKINS"
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
resource "azurerm_network_interface" "NetI1" {
  name                = "NetI1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  network_security_group_id = "${azurerm_network_security_group.NSG1.id}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${azurerm_subnet.Subnet1.id}"
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.1.4"
    public_ip_address_id = "${azurerm_public_ip.publicIP1.id}"
  }
}
resource "azurerm_virtual_machine" "vm1" {
  name                  = "vm1"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.NetI1.id}"]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "Openlogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }
  storage_os_disk {
    name              = "mydisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "syl20"
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