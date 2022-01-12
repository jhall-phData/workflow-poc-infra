terraform {
  backend "azurerm" {
    storage_account_name = "workflowpoc"
    container_name       = "tf-state"
    key                  = "workflow-poc-infra.tfstate"
  }
}