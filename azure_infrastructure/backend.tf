terraform {
  backend "azurerm" {
    subscription_id      = "858549e2-8aab-4d4f-ad8d-d87e01785d46"
    resource_group_name  = "DefaultResourceGroup-CUS"
    storage_account_name = "workflowpoc"
    container_name       = "tf-stateQA"
    key                  = "workflow-poc-infra.tfstate"
  }
}