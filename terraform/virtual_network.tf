# Create virtual network
resource "azurerm_virtual_network" "hardening_virtual_network" {
  name                = "hardening_virtual_network"
  address_space       = ["${var.network-prefix-ip}0.0/16"]
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location

  tags = {
    "Ver"     = var.current_version
    "Name"    = "hardening_virtual_network"
    "BuildBy" = var.BuildBy
  }
}
