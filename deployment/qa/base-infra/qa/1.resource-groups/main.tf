#create resource groups for DSP

module "mod_qa_resource_groups" {
  source          = "../../../../../modules/resourcegroups/"
  resource_groups = var.resource_groups
  location        = var.location
  rg_tags         = var.rg_tags
}
