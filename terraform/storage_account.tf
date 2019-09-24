# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    #resource_group_name          = azurerm_resource_group.minihardening_rg.name
    resource_group_name = data.azurerm_resource_group.resource_group.name
  }

  byte_length = 8
}
# Create storage account for boot diagnostics
resource "azurerm_storage_account" "diag-storage-account" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = data.azurerm_resource_group.resource_group.name
  location                 = data.azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-bastion-storage-account"
    "BuildBy" = var.BuildBy
  }
}
