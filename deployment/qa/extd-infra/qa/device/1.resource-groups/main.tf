#create resource groups for DSP

module "resource_groups" {
  source          = "../../../../../../modules/resourcegroups/"
  resource_groups = var.resource_groups
  location        = var.location
  rg_tags         = var.rg_tags
}
