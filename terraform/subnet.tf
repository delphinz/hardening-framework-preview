# Create subnet
resource "azurerm_subnet" "subnet-staff-common" {
  name                 = "subnet-staff-common"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.hardening_virtual_network.name

  # 192.168.200.0/24
  address_prefix = "${var.network-prefix-ip}${var.staff-ip-3octet}0/24"
}

resource "azurerm_subnet" "subnet-team-internal" {
  count = var.team-count
  name  = format("subnet-team-%s-internal", lookup(var.team-name, count.index + 1))

  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.hardening_virtual_network.name
  address_prefix       = "${var.network-prefix-ip}${var.team-ip-3octet + count.index + 1}.128/25"
}

resource "azurerm_subnet" "subnet-team-dmz" {
  count = var.team-count
  name  = format("subnet-team-%s-dmz", lookup(var.team-name, count.index + 1))

  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.hardening_virtual_network.name
  address_prefix       = "${var.network-prefix-ip}${var.team-ip-3octet + count.index + 1}.0/25"
}