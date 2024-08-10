data "azurerm_client_config" "current" {}

data "http" "ip" {
  url = "https://checkip.amazonaws.com"
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
}

resource "azurerm_resource_group" "this" {
  location = "Germany West Central"
  name     = module.naming.resource_group.name_unique
}

resource "azurerm_key_vault" "this" {
  name                        = module.naming.key_vault.name_unique
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 60
  purge_protection_enabled    = true

  public_network_access_enabled = true

  sku_name = "premium"

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules = [
      trimspace(data.http.ip.response_body),
    ]
  }
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete",
  ]

  storage_permissions = [
    "Get",
  ]
}
