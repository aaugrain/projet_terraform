#créer  un resource group
resource "azurerm_resource_group" "rg" {
    name = "${var.name}"
    location = "${var.location}"
}
#créer un virtual network
resource "azurerm_virtual_network" "myFirstVnet" {
    name = "${var.name_vnet}"
    address_space = "${var.adress_space}"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
}
resource "azurerm_subnet" "Subnet1" {
    name = "Subnet1"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.myFirstVnet.name}"
    address_prefix = "10.0.1.0/24"
}
resource "azurerm_subnet" "Subnet2" {
    name = "Subnet2"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.myFirstVnet.name}"
    address_prefix = "10.0.2.0/24"
}