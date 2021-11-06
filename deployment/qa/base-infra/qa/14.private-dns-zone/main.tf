# Create private dns zone
module "private_dns_zone" {
  source              = "../../../../../modules/private_dns_zone_multivn_link/"
  dns_zone_name       = var.dns_zone_name
  resource_group_name = var.resource_group_name
  zone_to_vnet_links  = var.zone_to_vnet_links
  tags                = var.tags
}

resource "azurerm_private_dns_cname_record" "apigee" {
  name                = var.apigee_dns_record_name
  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = 3600
  record              = var.apigee_dns_record_url
  depends_on          = [module.private_dns_zone]
}
