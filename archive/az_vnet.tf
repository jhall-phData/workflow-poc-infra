resource "azurerm_virtual_network" "eqrdp" {
  name                = "${var.prefix}-network"
  location            = azurerm_resource_group.eqrdp.location
  resource_group_name = azurerm_resource_group.eqrdp.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  virtual_network_name = azurerm_virtual_network.eqrdp.name
  resource_group_name  = azurerm_resource_group.eqrdp.name
  address_prefixes     = ["10.1.0.0/22"]
}