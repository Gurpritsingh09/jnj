
data "azurerm_resource_group" "fw_rg" {
  name     = var.azure_fw_resource_group
}

data "azurerm_firewall" "azure_fw_name" {
  name                = var.azure_fw_name
  resource_group_name = var.azure_fw_resource_group
}


data "azurerm_public_ip" "azure_firewall_public_ip"  {
  name                = var.azure_fw_public_ip_name
  resource_group_name = var.azure_fw_resource_group
}


