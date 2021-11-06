
data "azurerm_resource_group" "fw_rg" {
  name     = var.azure_fw_resource_group
}


# Pull Azure Firewall subnet

data "azurerm_subnet" "AzureFirewallSubnet" {
  name = "AzureFirewallSubnet" # mandatory name -do not rename-
  virtual_network_name = var.vnet_name
  resource_group_name  = var.azure_fw_resource_group
}

data "azurerm_public_ip" "public_ip" {
  name                = "${var.azure_fw_name}-pip"
  resource_group_name = var.azure_fw_resource_group
}
