data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "EUN-DS-QA-STG-TF"
    storage_account_name = "eunqaterraformsta"
    container_name       = "qa-deployment"
    key                  = "networking.tfstate"
  }
}

data "terraform_remote_state" "kv" {
  backend = "azurerm"

  config = {
    resource_group_name  = "EUN-DS-QA-STG-TF"
    storage_account_name = "eunqaterraformsta"
    container_name       = "qa-deployment"
    key                  = "keyvaults.tfstate"
  }
}

locals {
  resource_ids = {
    acr1 = module.ContainerRegistry.acr_id
  }
}

# Container Registry

module "ContainerRegistry" {
  source                         = "../../../../../../modules/ContainerRegistry"
  name                           = var.acr_name
  resource_group_name            = var.resource_group_name
  diagnostics_storage_account    = var.diagnostics_storage_account
  diagnostics_storage_account_rg = var.diagnostics_storage_account_rg
  tags                           = var.tags
}

# Private Endpoint

module "PrivateEndpoint" {
  source              = "../../../../../../modules/PrivateEndpoint"
  private_endpoints   = var.private_endpoints
  resource_group_name = var.pe_resource_group_name
  subnet_ids          = data.terraform_remote_state.vnet.outputs.map_subnets.subnet2.id
  vnet_ids            = data.terraform_remote_state.vnet.outputs.map_vnets.virtualnetwork1.id
  resource_ids        = local.resource_ids
}

