# Create network interface
resource "azurerm_network_interface" "staff-bastion-nif" {
  name                      = "staff-bastion-nif"
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  location                  = data.azurerm_resource_group.resource_group.location
  network_security_group_id = azurerm_network_security_group.staff-bastion-sg.id

  ip_configuration {
    name                          = "staff-bastion-nif-conf"
    subnet_id                     = azurerm_subnet.subnet-staff-common.id
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.network-prefix-ip}${var.staff-ip-3octet}10"
    public_ip_address_id          = azurerm_public_ip.staff-bastion-public-ip.id
  }
  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-bastion-nif"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_network_interface" "staff-kali-nif" {
  name                      = "staff-kali-nif"
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  location                  = data.azurerm_resource_group.resource_group.location
  network_security_group_id = azurerm_network_security_group.staff-common-sg.id

  ip_configuration {
    name                          = "staff-kali-nif-conf"
    subnet_id                     = azurerm_subnet.subnet-staff-common.id
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.network-prefix-ip}${var.staff-ip-3octet}20"
    public_ip_address_id          = azurerm_public_ip.staff-kali-public-ip.id
  }
  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-kali-nif"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_network_interface" "staff-win1-nif" {
  name                      = "staff-win1-nif"
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  location                  = data.azurerm_resource_group.resource_group.location
  network_security_group_id = azurerm_network_security_group.staff-common-sg.id

  ip_configuration {
    name                          = "staff-win1-nif-conf"
    subnet_id                     = azurerm_subnet.subnet-staff-common.id
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.network-prefix-ip}${var.staff-ip-3octet}101"
    public_ip_address_id          = azurerm_public_ip.staff-win1-public-ip.id
  }
  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-win1-nif"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_network_interface" "staff-win2-nif" {
  name                      = "staff-win2-nif"
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  location                  = data.azurerm_resource_group.resource_group.location
  network_security_group_id = azurerm_network_security_group.staff-common-sg.id

  ip_configuration {
    name                          = "staff-win2-nif-conf"
    subnet_id                     = azurerm_subnet.subnet-staff-common.id
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.network-prefix-ip}${var.staff-ip-3octet}102"

    public_ip_address_id = azurerm_public_ip.staff-win2-public-ip.id
  }
  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-win2-nif"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_network_interface" "team-bastion-nif" {
  count                     = var.team-count
  name                      = format("team-%s-bastion-nif", lookup(var.team-name, count.index + 1))
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  location                  = data.azurerm_resource_group.resource_group.location
  network_security_group_id = element(azurerm_network_security_group.team-bastion-sg.*.id, count.index)

  ip_configuration {
    name                          = "team-bastion-nif-conf"
    subnet_id                     = element(azurerm_subnet.subnet-team-dmz.*.id, count.index)
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.network-prefix-ip}${100 + count.index + 1}.10"
    public_ip_address_id          = element(azurerm_public_ip.team-bastion-public-ip.*.id, count.index)
  }

  tags = {
    "Ver"     = var.current_version
    "Name"    = "team-bastion-nif"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_network_interface" "team-linux-nif" {
  count                     = var.team-count
  name                      = format("team-%s-linux-nif", lookup(var.team-name, count.index + 1))
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  location                  = data.azurerm_resource_group.resource_group.location
  network_security_group_id = element(azurerm_network_security_group.team-common-sg.*.id, count.index)

  ip_configuration {
    name                          = "team-linux-nif-conf"
    subnet_id                     = element(azurerm_subnet.subnet-team-dmz.*.id, count.index)
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.network-prefix-ip}${100 + count.index + 1}.30"
    # public_ip_address_id          = element(azurerm_public_ip.team-linux-public-ip.*.id, count.index)
  }

  tags = {
    "Ver"     = var.current_version
    "Name"    = "team-linux-nif"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_network_interface" "team-win1-nif" {
  count                     = var.team-count
  name                      = format("team-%s-win1-nif", lookup(var.team-name, count.index + 1))
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  location                  = data.azurerm_resource_group.resource_group.location
  network_security_group_id = element(azurerm_network_security_group.team-common-sg.*.id, count.index)

  ip_configuration {
    name                          = "team-win1-nif-conf"
    subnet_id                     = element(azurerm_subnet.subnet-team-internal.*.id, count.index)
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.network-prefix-ip}${100 + count.index + 1}.151"
    # public_ip_address_id          = element(azurerm_public_ip.team-win1-public-ip.*.id, count.index)

  }

  tags = {
    "Ver"     = var.current_version
    "Name"    = "team-win1-nif"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_network_interface" "team-win2-nif" {
  count                     = var.team-count
  name                      = format("team-%s-win2-nif", lookup(var.team-name, count.index + 1))
  resource_group_name       = data.azurerm_resource_group.resource_group.name
  location                  = data.azurerm_resource_group.resource_group.location
  network_security_group_id = element(azurerm_network_security_group.team-common-sg.*.id, count.index)

  ip_configuration {
    name                          = "team-win2-nif-conf"
    subnet_id                     = element(azurerm_subnet.subnet-team-internal.*.id, count.index)
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.network-prefix-ip}${100 + count.index + 1}.152"
    # public_ip_address_id          = element(azurerm_public_ip.team-win2-public-ip.*.id, count.index)
  }

  tags = {
    "Ver"     = var.current_version
    "Name"    = "team-win2-nif"
    "BuildBy" = var.BuildBy
  }
}
