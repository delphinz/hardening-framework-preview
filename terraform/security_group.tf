# # Create Network Security Group and rule
resource "azurerm_network_security_group" "staff-bastion-sg" {
  name                = "staff-bastion-sg"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-bastion-sg"
    "BuildBy" = var.BuildBy
  }
}

# SG for staff common inbound
resource "azurerm_network_security_group" "staff-common-sg" {
  name = "staff-common-sg"

  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location

  security_rule {
    name                       = "Outbound-all"
    priority                   = 1099
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-common-sg"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_network_security_group" "team-bastion-sg" {
  count               = var.team-count
  name                = format("team-%s-bastion-sg", lookup(var.team-name, count.index + 1))
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "OutTeam"
    priority                   = 4001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "${var.network-prefix-ip}${100 + count.index + 1}"
  }

  security_rule {
    name                       = "OutCommon"
    priority                   = 4002
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "${var.network-prefix-ip}200"
  }

  security_rule {
    name                       = "OutAll"
    priority                   = 4090
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "${var.network-prefix-ip}200"
  }

  tags = {
    "Ver"     = var.current_version
    "Name"    = "team-bastion-sg"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_network_security_group" "team-common-sg" {
  count = var.team-count
  name  = format("team-%s-common-sg", lookup(var.team-name, count.index + 1))

  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location

  security_rule {
    name                       = "Inteam"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "${var.network-prefix-ip}${100 + count.index + 1}"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Instaff"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "${var.network-prefix-ip}200"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "OutAll"
    priority                   = 4001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "${var.network-prefix-ip}200"
    destination_address_prefix = "*"

    #source_application_security_group_ids =""
    #destination_application_security_group_ids =""
  }

  tags = {
    "Ver"     = var.current_version
    "Name"    = "team-common-sg"
    "BuildBy" = var.BuildBy
  }
}
