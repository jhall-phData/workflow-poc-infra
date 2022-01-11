
resource "azurerm_resource_group" "eqrdp" {
  name     = "${var.env}-${var.prefix}-rg"
  location = var.az_region
}