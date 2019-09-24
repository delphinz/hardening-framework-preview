data "azurerm_image" "metasploitable3" {
  name_regex          = "metasploitable3"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}
