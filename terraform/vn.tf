resource "azurerm_resource_group" "rg"{
    name= "${var.name}"
    location= "${var.location}"
    tags {
        owner= "${var.owner}"
    }
}
#créer un virtual network

resource "azurerm_virtual_network" "Vnet"{
    name= "${var.name_vnet}"
    address_space= "${var.add_space}"
    location= "${var.location}"
    resource_group_name= "${var.name}"
}
# créer 3 subnet

resource "azurerm_subnet" "subnet1" {
    name= "${var.name_subnet1}"
    resource_group_name= "${var.name}"
    virtual_network_name= "${var.name_vnet}"
    address_prefix= "${var.add_prefix1}"
}
resource "azurerm_subnet" "subnet2" {
    name= "${var.name_subnet2}"
    resource_group_name= "${var.name}"
    virtual_network_name= "${var.name_vnet}"
    address_prefix= "${var.add_prefix2}"
}
resource "azurerm_subnet" "subnet3" {
    name= "${var.name_subnet3}"
    resource_group_name= "${var.name}"
    virtual_network_name= "${var.name_vnet}"
    address_prefix= "${var.add_prefix3}"
}
# créer 3 network security group

resource "azurerm_network_security_group" "NSG1" {
    name= "${var.name_nsg1}"
    location= "${var.location}"
    resource_group_name= "${var.name}"
    security_rule {
        name= "SSH"
        priority= 1001
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "22"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }
    security_rule {
        name= "HTTP"
        priority= 1002
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "80"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }
    security_rule {
        name= "HTTPS"
        priority= 1003
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "443"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }
    security_rule {
        name= "jenkins"
        priority= 1004
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "8080"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }   
}
resource "azurerm_network_security_group" "NSG2" {
    name= "${var.name_nsg2}"
    location= "${var.location}"
    resource_group_name= "${var.name}"
    security_rule {
        name= "SSH"
        priority= 1001
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "22"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }
    security_rule {
        name= "HTTP"
        priority= 1002
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "80"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }
    security_rule {
        name= "HTTPS"
        priority= 1003
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "443"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }
}
resource "azurerm_network_security_group" "NSG3" {
    name= "${var.name_nsg3}"
    location= "${var.location}"
    resource_group_name= "${var.name}"
    security_rule {
        name= "SSH"
        priority= 1001
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "22"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }
    security_rule {
        name= "HTTP"
        priority= 1002
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "80"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }
    security_rule {
        name= "HTTPS"
        priority= 1003
        direction= "Inbound"
        access= "Allow"
        protocol= "TCP"
        source_port_range= "*"
        destination_port_range= "443"
        source_address_prefix= "*"
        destination_address_prefix= "*"
    }
}
resource "azurerm_public_ip" "PubIp" {
    name= "${var.name_pubIp}"
    location= "${var.location}"
    resource_group_name= "${var.name}"
    allocation_method= "${var.allocation_method}"
    domain_name_label= "dnsalex"
}
resource "azurerm_network_interface" "NIC1" {
    name= "${var.nameNIC1}"
    location= "${var.location}"
    resource_group_name= "${var.name}"
    network_security_group_id= "${azurerm_network_security_group.NSG1.id}"
    ip_configuration {
        name= "${var.nameNIC1config}"
        subnet_id= "${azurerm_subnet.subnet1.id}"
        private_ip_address_allocation= "${var.allocation_method}"
	    public_ip_address_id= "${azurerm_public_ip.PubIp.id}"
    }
}
resource "azurerm_network_interface" "NIC2" {
    name= "${var.nameNIC2}"
    location= "${var.location}"
    resource_group_name= "${var.name}"
    network_security_group_id= "${azurerm_network_security_group.NSG2.id}"
    ip_configuration {
        name= "${var.nameNIC2config}"
        subnet_id= "${azurerm_subnet.subnet2.id}"
        private_ip_address_allocation= "${var.allocation_method}"
    }
}
resource "azurerm_network_interface" "NIC3" {
    name= "${var.nameNIC3}"
    location= "${var.location}"
    resource_group_name= "${var.name}"
    network_security_group_id= "${azurerm_network_security_group.NSG3.id}"
    ip_configuration {
        name= "${var.nameNIC3config}"
        subnet_id= "${azurerm_subnet.subnet3.id}"
        private_ip_address_allocation= "${var.allocation_method}"
    }
}
resource "azurerm_managed_disk" "DiskData1" {
    name                = "${var.name_datadisk1}"
    location            = "${var.location}"
    resource_group_name = "${var.name}"
    storage_account_type= "Standard_LRS"
    create_option       = "Empty"
    disk_size_gb        = "1023"
}
resource "azurerm_managed_disk" "DiskData2" {
    name                = "${var.name_datadisk2}"
    location            = "${var.location}"
    resource_group_name = "${var.name}"
    storage_account_type= "Standard_LRS"
    create_option       = "Empty"
    disk_size_gb        = "1023"
}