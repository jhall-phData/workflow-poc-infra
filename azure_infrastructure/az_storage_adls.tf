
resource "azurerm_user_assigned_identity" "eqrdp" {
  name                = "workflowpoc_sp"
  resource_group_name = azurerm_resource_group.eqrdp.name
  location            = azurerm_resource_group.eqrdp.location
}

resource "azurerm_storage_account" "eqrdp" {
  name                = "${var.env}${var.prefix}storageacct"
  resource_group_name = azurerm_resource_group.eqrdp.name
  location            = azurerm_resource_group.eqrdp.location

  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  is_hns_enabled = true
  min_tls_version = "TLS1_2"
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "storageAccountRoleAssignment" {
  scope                = azurerm_storage_account.eqrdp.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_storage_data_lake_gen2_filesystem" "eqrdp" {
  name               = "eqrdp"
  storage_account_id = azurerm_storage_account.eqrdp.id
  ace {
    type        = "user"
    permissions = "rwx"
  }
  ace {
    type        = "user"
    id          = azurerm_user_assigned_identity.eqrdp.principal_id
    permissions = "--x"
  }
  ace {
    type        = "group"
    permissions = "r-x"
  }
  ace {
    type        = "mask"
    permissions = "r-x"
  }
  ace {
    type        = "other"
    permissions = "---"
  }
  depends_on = [
    azurerm_role_assignment.storageAccountRoleAssignment
  ]
}

resource "azurerm_storage_data_lake_gen2_path" "eqrdp" {
  storage_account_id = azurerm_storage_account.eqrdp.id
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.eqrdp.name
  path               = "testpath"
  resource           = "directory"
  ace {
    type        = "user"
    permissions = "r-x"
  }
  ace {
    type        = "user"
    id          = azurerm_user_assigned_identity.eqrdp.principal_id
    permissions = "r-x"
  }
  ace {
    type        = "group"
    permissions = "-wx"
  }
  ace {
    type        = "mask"
    permissions = "--x"
  }
  ace {
    type        = "other"
    permissions = "--x"
  }
  ace {
    scope       = "default"
    type        = "user"
    permissions = "r-x"
  }
  ace {
    scope       = "default"
    type        = "user"
    id          = azurerm_user_assigned_identity.eqrdp.principal_id
    permissions = "r-x"
  }
  ace {
    scope       = "default"
    type        = "group"
    permissions = "-wx"
  }
  ace {
    scope       = "default"
    type        = "mask"
    permissions = "--x"
  }
  ace {
    scope       = "default"
    type        = "other"
    permissions = "--x"
  }
}

