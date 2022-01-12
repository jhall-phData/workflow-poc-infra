terraform {
  backend "azurerm" {
    resource_group_name  = "DefaultResourceGroup-CUS"
    storage_account_name = "workflowpoc"
    container_name       = "tf-state"
    key                  = "workflow-poc-infra.tfstate"
    }
}