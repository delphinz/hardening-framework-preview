# common.tf
# Common variable for Terraform provider

# provider
# It's nessesary to export environment for Terraform （Pls check  readme.md）
provider "azurerm" {
  # version = "=2.0.0"
}

# Before terraform executes, make resource group
data "azurerm_resource_group" "resource_group" {
  name = "${var.resource_group_name}-${terraform.workspace}-rg"
}

# Create a resource group if it doesn’t exist
# resource "azurerm_resource_group" "hardening_rg" {
#   name     = "${var.network-prefix-name}-rg"
#   location = var.location


