
# Network

module "BaseInfrastructure" {
  source                           = "../../../../../modules/Network"
  resource_group_name              = var.resource_group_name       
  virtual_networks                 = var.virtual_networks                 
  subnets                          = var.subnets                         
  route_tables                     = var.route_tables                     
  network_security_groups          = var.network_security_groups          
  vnet_peering                     = {}   
  app_security_group_ids_map       = {}  
  diagnostics_storage_account      = var.diagnostics_storage_account
  diagnostics_storage_account_rg   = var.diagnostics_storage_account_rg       
  tags                             = var.tags
}
