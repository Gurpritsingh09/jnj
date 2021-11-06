data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "EUN-DS-QA-STG-TF"
    storage_account_name = "eunqaterraformsta"
    container_name       = "qa-deployment"
    key                  = "networking.tfstate"
  }
}


locals {
  resource_ids = {
    keyvault = module.Keyvault.key_vault_id
  }

}

# Key Vault 

module "Keyvault" {
  source                          = "../../../../../../modules/KeyVault"
  resource_group_name             = var.resource_group_name
  name                            = var.keyvault_name
  soft_delete_enabled             = var.soft_delete_enabled
  purge_protection_enabled        = var.purge_protection_enabled
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  sku_name                        = var.sku_name
  access_policies                 = var.access_policies
  network_acls                    = var.network_acls
  diagnostics_storage_account     = var.diagnostics_storage_account
  diagnostics_storage_account_rg  = var.diagnostics_storage_account_rg
  tags                            = var.tags
}

# Private Endpoint

module "PrivateEndpoint" {
  source              = "../../../../../../modules/PrivateEndpoint"
  private_endpoints   = var.private_endpoints
  resource_group_name = var.pe_resource_group_name
  subnet_ids          = data.terraform_remote_state.vnet.outputs.map_subnets.subnet2.id
  vnet_ids            = data.terraform_remote_state.vnet.outputs.map_vnets.virtualnetwork1.id
  resource_ids        = local.resource_ids
  tags                = var.tags
}
