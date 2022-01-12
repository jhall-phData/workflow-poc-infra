provider "azurerm" {
  features {}
  subscription_id = "858549e2-8aab-4d4f-ad8d-d87e01785d46"
  client_id = var.workflow-poc-sp-client_id
  client_secret = var.workflow-poc-sp-secret
  tenant_id = var.workflow-poc-sp-tenant-id
}
