# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "858549e2-8aab-4d4f-ad8d-d87e01785d46"
  client_id       = var.workflow-poc-sp-client-id
  client_secret   = var.workflow-poc-sp-secret
  tenant_id       = var.workflow-poc-sp-tenant-id
}

