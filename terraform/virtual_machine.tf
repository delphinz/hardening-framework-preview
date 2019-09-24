# # Create virtual machine
resource "azurerm_virtual_machine" "staff-bastion-vm" {
  delete_data_disks_on_termination = true
  name                             = "staff-bastion-vm"
  resource_group_name              = data.azurerm_resource_group.resource_group.name
  location                         = data.azurerm_resource_group.resource_group.location
  network_interface_ids            = [azurerm_network_interface.staff-bastion-nif.id]
  vm_size                          = var.vm_size["vm_7GB"]

  storage_os_disk {
    name              = "staff-bastion-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = element(split(",", lookup(var.standard_os, "CentOS", "")), 0)
    offer     = element(split(",", lookup(var.standard_os, "CentOS", "")), 1)
    sku       = element(split(",", lookup(var.standard_os, "CentOS", "")), 2)
    version   = "latest"
  }
  os_profile {
    computer_name  = "staff-bastion"
    admin_username = var.default_user["centos"]
  }
  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.default_user["centos"]}/.ssh/authorized_keys"
      key_data = file(var.ssh-staff-pub-key)
    }
  }
  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.diag-storage-account.primary_blob_endpoint
  }
  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-bastion-vm"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_virtual_machine" "staff-kali-vm" {
  delete_data_disks_on_termination = true
  name                             = "staff-kali-vm"
  resource_group_name              = data.azurerm_resource_group.resource_group.name
  location                         = data.azurerm_resource_group.resource_group.location
  network_interface_ids            = [azurerm_network_interface.staff-kali-nif.id]
  vm_size                          = var.vm_size["vm_7GB"]

  storage_os_disk {
    name              = "staff-kali-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = element(split(",", lookup(var.standard_os, "Kali", "")), 0)
    offer     = element(split(",", lookup(var.standard_os, "Kali", "")), 1)
    sku       = element(split(",", lookup(var.standard_os, "Kali", "")), 2)
    version   = "latest"
  }
  plan {
    name      = element(split(",", lookup(var.standard_os, "Kali", "")), 2)
    publisher = element(split(",", lookup(var.standard_os, "Kali", "")), 0)
    product   = element(split(",", lookup(var.standard_os, "Kali", "")), 1)
  }
  os_profile {
    computer_name  = "staff-kali"
    admin_username = var.default_user["kali"]
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.default_user["kali"]}/.ssh/authorized_keys"
      key_data = file(var.ssh-staff-pub-key)
    }
  }
  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.diag-storage-account.primary_blob_endpoint
  }
  tags = {
    "Ver"     = var.current_version
    "Name"    = "staff-kali-vm"
    "BuildBy" = var.BuildBy
  }
}

resource "azurerm_virtual_machine" "staff-win1" {
  delete_data_disks_on_termination = true
  name                             = "staff-win1-vm"
  resource_group_name              = data.azurerm_resource_group.resource_group.name
  location                         = data.azurerm_resource_group.resource_group.location
  network_interface_ids            = [azurerm_network_interface.staff-win1-nif.id]
  vm_size                          = var.vm_size["vm_7GB"]

  storage_os_disk {
    name              = "staff-win1-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = element(split(",", lookup(var.standard_os, "Win10", "")), 0)
    offer     = element(split(",", lookup(var.standard_os, "Win10", "")), 1)
    sku       = element(split(",", lookup(var.standard_os, "Win10", "")), 2)
    version   = "latest"
  }
  os_profile {
    computer_name = "staff-win1"

    admin_username = var.default_user["win1"]
    admin_password = var.password["windows"]
  }
  os_profile_windows_config {
    enable_automatic_upgrades = false
  }
  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.diag-storage-account.primary_blob_endpoint
  }
  tags = {
    "sleep"   = "auto"
    "BuildBy" = var.BuildBy
    "Name"    = "staff-win1"
    "Ver"     = var.current_version
    # terraform-inventory tag
    "Env"  = "staff"
    "Role" = "staff_win1"
    "Os"   = "windows"
  }
}

resource "azurerm_virtual_machine" "staff-win2" {
  delete_data_disks_on_termination = true
  name                             = "staff-win2-vm"
  resource_group_name              = data.azurerm_resource_group.resource_group.name
  location                         = data.azurerm_resource_group.resource_group.location
  network_interface_ids            = [azurerm_network_interface.staff-win2-nif.id]
  vm_size                          = var.vm_size["vm_7GB"]

  storage_os_disk {
    name              = "staff-win2-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = element(split(",", lookup(var.standard_os, "Win7", "")), 0)
    offer     = element(split(",", lookup(var.standard_os, "Win7", "")), 1)
    sku       = element(split(",", lookup(var.standard_os, "Win7", "")), 2)
    version   = "latest"
  }
  os_profile {
    computer_name  = "staff-win2"
    admin_username = var.default_user["win1"]
    admin_password = var.password["windows7"]
  }
  os_profile_windows_config {
    enable_automatic_upgrades = false
  }
  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.diag-storage-account.primary_blob_endpoint
  }
  tags = {
    "sleep"   = "auto"
    "BuildBy" = var.BuildBy
    "Name"    = "staff-win2"
    "Ver"     = var.current_version
    # terraform-inventory tag
    "Env"  = "staff"
    "Role" = "staff_win2"
    "Os"   = "windows7"
  }
}

resource "azurerm_virtual_machine" "team-bastion-vm" {
  count                 = var.team-count
  name                  = format("team-%s-bastion", lookup(var.team-name, count.index + 1))
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  location              = data.azurerm_resource_group.resource_group.location
  network_interface_ids = [element(azurerm_network_interface.team-bastion-nif.*.id, count.index)]
  vm_size               = var.vm_size["vm_4GB"]

  storage_os_disk {
    name              = format("team-%s-bastion-disk", lookup(var.team-name, count.index + 1))
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = element(split(",", lookup(var.standard_os, "CentOS", "")), 0)
    offer     = element(split(",", lookup(var.standard_os, "CentOS", "")), 1)
    sku       = element(split(",", lookup(var.standard_os, "CentOS", "")), 2)
    version   = "latest"
  }
  os_profile {
    computer_name  = format("team-%s-bastion", lookup(var.team-name, count.index + 1))
    admin_username = var.default_user["centos"]
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.default_user["centos"]}/.ssh/authorized_keys"
      key_data = file(var.ssh-team-pub-key)
    }
  }
  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.diag-storage-account.primary_blob_endpoint
  }
  tags = {
    "Ver"     = var.current_version
    "Name"    = format("team-%s-bastion", lookup(var.team-name, count.index + 1))
    "BuildBy" = var.BuildBy
  }
}


resource "azurerm_virtual_machine" "team-linux-vm" {
  count                 = var.team-count
  name                  = format("team-%s-linux", lookup(var.team-name, count.index + 1))
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  location              = data.azurerm_resource_group.resource_group.location
  network_interface_ids = [element(azurerm_network_interface.team-linux-nif.*.id, count.index)]
  vm_size               = var.vm_size["vm_4GB"]

  storage_os_disk {
    name              = format("team-%s-linux-disk", lookup(var.team-name, count.index + 1))
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    # publisher = element(split(",", lookup(var.standard_os, "UbuntuServer14", "")), 0)
    # offer     = element(split(",", lookup(var.standard_os, "UbuntuServer14", "")), 1)
    # sku       = element(split(",", lookup(var.standard_os, "UbuntuServer14", "")), 2)
    # version   = "latest"
    id = data.azurerm_image.metasploitable3.id
  }
  os_profile {
    computer_name  = format("team-%s-linux", lookup(var.team-name, count.index + 1))
    admin_username = var.default_user["ubuntu"]
    admin_password = var.password["windows"]
  }
  os_profile_linux_config {
    disable_password_authentication = false
    # ssh_keys {
    #   path     = "/home/${var.default_user["ubuntu"]}/.ssh/authorized_keys"
    #   key_data = file(var.ssh-team-pub-key)
    # }
  }
  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.diag-storage-account.primary_blob_endpoint
  }
  tags = {
    "Ver"     = var.current_version
    "Name"    = format("team-%s-linux", lookup(var.team-name, count.index + 1))
    "BuildBy" = var.BuildBy
    "sleep"   = "auto"
    # terraform-inventory tag
    "Env"  = "team"
    "Role" = "team-linux"
    "Os"   = "ubuntu"
  }
}

resource "azurerm_virtual_machine" "team-win1" {
  delete_data_disks_on_termination = true
  count                            = var.team-count
  name                             = format("team-%s-win1", lookup(var.team-name, count.index + 1))
  resource_group_name              = data.azurerm_resource_group.resource_group.name
  location                         = data.azurerm_resource_group.resource_group.location
  network_interface_ids            = [element(azurerm_network_interface.team-win1-nif.*.id, count.index)]
  vm_size                          = var.vm_size["vm_7GB"]

  storage_os_disk {
    name              = format("team-%s-win1-disk", lookup(var.team-name, count.index + 1))
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = element(split(",", lookup(var.standard_os, "Win10", "")), 0)
    offer     = element(split(",", lookup(var.standard_os, "Win10", "")), 1)
    sku       = element(split(",", lookup(var.standard_os, "Win10", "")), 2)
    version   = "latest"
  }
  os_profile {
    computer_name  = format("team-%s-win1", lookup(var.team-name, count.index + 1))
    admin_username = var.default_user["win1"]
    admin_password = var.password["windows"]
  }
  os_profile_windows_config {
    enable_automatic_upgrades = false
  }
  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.diag-storage-account.primary_blob_endpoint
  }
  tags = {
    "sleep"   = "auto"
    "BuildBy" = var.BuildBy
    "Name"    = "team-win1"
    "Ver"     = var.current_version
    # terraform-inventory tag
    "Env"  = "team"
    "Role" = "team-win1"
    "Os"   = "windows"
  }
}

resource "azurerm_virtual_machine" "team-win2" {
  delete_data_disks_on_termination = true
  count                            = var.team-count
  name                             = format("team-%s-win2", lookup(var.team-name, count.index + 1))
  resource_group_name              = data.azurerm_resource_group.resource_group.name
  location                         = data.azurerm_resource_group.resource_group.location
  network_interface_ids            = [element(azurerm_network_interface.team-win2-nif.*.id, count.index)]
  vm_size                          = var.vm_size["vm_7GB"]

  storage_os_disk {
    name              = format("team-%s-win2-disk", lookup(var.team-name, count.index + 1))
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = element(split(",", lookup(var.standard_os, "Win7", "")), 0)
    offer     = element(split(",", lookup(var.standard_os, "Win7", "")), 1)
    sku       = element(split(",", lookup(var.standard_os, "Win7", "")), 2)
    version   = "latest"
  }
  os_profile {
    computer_name  = format("team-%s-win2", lookup(var.team-name, count.index + 1))
    admin_username = var.default_user["win2"]
    admin_password = var.password["windows7"]
  }
  os_profile_windows_config {
    enable_automatic_upgrades = false
  }
  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.diag-storage-account.primary_blob_endpoint
  }
  tags = {
    "sleep"   = "auto"
    "BuildBy" = var.BuildBy
    "Name"    = "team-win2"
    "Ver"     = var.current_version
    # terraform-inventory tag
    "Env"  = "team"
    "Role" = "team-win2"
    "Os"   = "windows7"
  }
}

