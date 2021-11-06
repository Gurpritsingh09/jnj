# Create the public ip 
module "public_ip" {
  source                      = "../../modules/public-ip/"
  public_ip_name              = "DSP-PRM-FW-Terraform-pip1"
  public_ip_resource_group    = "NA-DS-NPD-NWK-SH"
  public_ip_location          = "North Europe"
  public_ip_allocation_method = "Static"
  public_ip_sku               = "Standard"
  public_ip_tags = {
    environment = "terraform-test"
    owner       = "Infra team"
    created-by  = "vdubey3"
  }

}

