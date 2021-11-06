module "subnet_add" {
  source                  = "../../../../../../modules/subnet_add"
  resource_group_name     = var.resource_group_name
  virtual_networks        = var.virtual_networks
  subnets                 = var.subnets
  network_security_groups = var.network_security_groups
  route_tables            = var.route_tables
}
