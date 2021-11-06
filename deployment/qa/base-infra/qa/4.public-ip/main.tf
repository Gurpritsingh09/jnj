# Create public IP for PRM Firewall

module "ds-qa-prm-fw-pip" {
  source                      = "../../../../../modules/public-ip/"
  public_ip_name              = "ds-qa-prm-fw-pip"
  public_ip_resource_group    = "EUN-DS-QA-NWK-SH"
  public_ip_location          = "North Europe"
  public_ip_allocation_method = "Static"
  public_ip_sku               = "Standard"
  public_ip_tags = {
    environment = "qa"
    owner       = "Infra team"
    created-by  = "Terraform Provisioned"
  }

}

# Create public IP for VPN

module "ds-qa-vpn-pip" {
  source                      = "../../../../../modules/public-ip/"
  public_ip_name              = "ds-qa-vpn"
  public_ip_resource_group    = "EUN-DS-QA-NWK-SH"
  public_ip_location          = "North Europe"
  public_ip_allocation_method = "Static"
  public_ip_sku               = "Standard"
  public_ip_tags = {
    environment = "qa"
    owner       = "Infra team"
    created-by  = "Terraform Provisioned"
  }

}
