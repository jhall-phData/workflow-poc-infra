
resource "azurerm_kubernetes_cluster" "eqrdp" {
  name                = "${var.env}-${var.prefix}-k8s"
  location            = azurerm_resource_group.eqrdp.location
  resource_group_name = azurerm_resource_group.eqrdp.name
  dns_prefix          = "${var.env}-${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
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

resource "azurerm_kubernetes_cluster_node_pool" "k8sworkflowpool" {
  name                  = "devworkflow"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.eqrdp.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    Environment = "dev"
  }
}
