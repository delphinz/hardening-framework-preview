data "azurerm_public_ip" "test" {
  name                = azurerm_public_ip.staff-bastion-public-ip.name
  resource_group_name = data.azurerm_resource_group.resource_group.name
}
output "command_ssh_staff_bastion" {
  value = "\nssh -o StrictHostKeyChecking=no -i ${var.ssh-staff-sec-key}  ${var.default_user["default"]}@${azurerm_public_ip.staff-bastion-public-ip.ip_address} \n"
}

output "command_ssh_kali_via_staff_bastion" {
  value = "\n\nssh -o StrictHostKeyChecking=no  -o ProxyCommand='ssh -o StrictHostKeyChecking=no -W %h:%p -i ${var.ssh-staff-sec-key}  centos@${azurerm_public_ip.staff-bastion-public-ip.ip_address}' -i ${var.ssh-staff-sec-key}  kali@${var.network-prefix-ip}200.20\n"
}

output "command_ssh_staff-win1-rdp_via_bastion" {
  value = "\nssh -o StrictHostKeyChecking=no  -L 3389:${var.network-prefix-ip}200.101:3389 -L 5985:${var.network-prefix-ip}200.101:5985 -i ${var.ssh-staff-sec-key}  centos@${azurerm_public_ip.staff-bastion-public-ip.ip_address}\n"
}
