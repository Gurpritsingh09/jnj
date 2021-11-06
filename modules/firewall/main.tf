# Create the public ip for Azure Firewall - replaced via public-ip module

#resource "azurerm_public_ip" "azure_firewall_public_ip" {
  #count = var.azure_fw_public_ip == "" ? 1 : 0
#  name = "${var.azure_fw_name}-pip"
#  resource_group_name = var.azure_fw_resource_group
#  location = var.azure_fw_location
#  allocation_method = "Static"
#  sku = "Standard"
#  tags = var.tags
#}

# Create the Azure Firewall
resource "azurerm_firewall" "azure_firewall" {
#  depends_on          = [module.public_ip.public_ip]
  name                = var.azure_fw_name 
  resource_group_name = var.azure_fw_resource_group
  location            = var.azure_fw_location
  ip_configuration {
    name = "ipconfig-${var.azure_fw_location}-${var.azure_fw_name}"
    subnet_id = data.azurerm_subnet.AzureFirewallSubnet.id
#    public_ip_address_id = module.public_ip.public_ip.id
    public_ip_address_id = data.azurerm_public_ip.public_ip.id
  }

  tags = var.tags
}
