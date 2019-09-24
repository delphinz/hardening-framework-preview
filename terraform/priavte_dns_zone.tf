# azure dns  zone

resource "azurerm_private_dns_zone" "local-dns-zone" {
  name                = "${var.network-prefix-name}.local"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  # resolution_virtual_network_ids = [azurerm_virtual_network.hardening_virtual_network.id]
  # TODO: I don't find how to link with virtual network!

  tags = {
    "Ver"     = var.current_version
    "BuildBy" = "terraform"
    "Name"    = "local-dns-zone"
  }
}
