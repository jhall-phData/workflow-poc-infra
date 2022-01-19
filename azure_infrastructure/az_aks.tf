
resource "azurerm_kubernetes_cluster" "eqrdp" {
  name                = "${var.env}-${var.prefix}-k8s"
  location            = azurerm_resource_group.eqrdp.location
  resource_group_name = azurerm_resource_group.eqrdp.name
  dns_prefix          = "${var.env}-${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }
}

# add the role to the identity the kubernetes cluster was assigned
resource "azurerm_role_assignment" "poc_aks_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.eqrdp.kubelet_identity[0].object_id
}


# add agent pool to key vault!!!
data "azurerm_key_vault" "poc-kv" {
  name                = "workflow-poc-kv001"
  resource_group_name = "DefaultResourceGroup-CUS"
}

resource "azurerm_key_vault_access_policy" "poc-kv-policy" {
  key_vault_id = data.azurerm_key_vault.poc-kv.id
  tenant_id    = azurerm_kubernetes_cluster.eqrdp.kubelet_identity[0].client_id
  object_id    = azurerm_kubernetes_cluster.eqrdp.kubelet_identity[0].object_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

data "azurerm_storage_account" "poc-storage" {
  name                = "workflowpoc"
  resource_group_name = "DefaultResourceGroup-CUS"
}

resource "azurerm_role_assignment" "data-contributor-role" {
  scope                = data.azurerm_storage_account.poc-storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_kubernetes_cluster.eqrdp.kubelet_identity[0].object_id
}