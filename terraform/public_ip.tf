# Create public IPs
resource "azurerm_public_ip" "staff-bastion-public-ip" {
  name                = "staff-bastion-public-ip"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.network-prefix-name}-staff-bastion"

  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-bastion-public-ip"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_public_ip" "staff-kali-public-ip" {
  name                = "staff-kali-public-ip"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.network-prefix-name}-staff-kali"

  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-kali-public-ip"
    "BuildBy" = var.BuildBy
  }
}
resource "azurerm_public_ip" "staff-win1-public-ip" {
  name                = "staff-win1-public-ip"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.network-prefix-name}-staff-win1"

  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-win1-public-ip"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_public_ip" "staff-win2-public-ip" {
  name = "staff-win2-public-ip"

  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.network-prefix-name}-staff-win2"

  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-win2-public-ip"
    "BuildBy" = var.BuildBy
  }
}


resource "azurerm_public_ip" "team-bastion-public-ip" {
  count               = var.team-count
  name                = format("team-%s-bastion-public-ip", lookup(var.team-name, count.index + 1))
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  allocation_method   = "Dynamic"
  domain_name_label   = format("team-%s-bastion-public-ip", lookup(var.team-name, count.index + 1))

  tags = {
    "Ver"     = var.current_version
    "Name"    = format("team-%s-bastion-public-ip", lookup(var.team-name, count.index + 1))
    "BuildBy" = var.BuildBy
  }
}


# resource "azurerm_public_ip" "team-linux-public-ip" {
#   count = var.team-count
#   name  = format("team-%s-linux-public-ip", lookup(var.team-name, count.index + 1))
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   location            = data.azurerm_resource_group.resource_group.location
#   allocation_method   = "Dynamic"
#   domain_name_label   = format("team-%s-linux-public-ip", lookup(var.team-name, count.index + 1))

#   tags = {
#     "Ver"     = var.current_version
#     "Name"    = format("team-%s-linux-public-ip", lookup(var.team-name, count.index + 1))
#     "BuildBy" = var.BuildBy
#   }
# }

