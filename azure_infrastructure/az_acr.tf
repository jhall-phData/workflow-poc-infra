resource "azurerm_container_registry" "acr" {
  name                     = "workflowpocacr001"
  location            = azurerm_resource_group.eqrdp.location
  resource_group_name = azurerm_resource_group.eqrdp.name
  sku                      = "Basic"
  admin_enabled            = true
}
