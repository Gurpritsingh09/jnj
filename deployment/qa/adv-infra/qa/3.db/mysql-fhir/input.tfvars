# MySQL Database

resource_group_name    = "EUN-DS-QA-SQL-FHR"
pe_resource_group_name = "EUN-DS-QA-NWK-SH"
tags = {
  source       = "terraform"
  environment  = "qa"
  application  = "DS"
  service      = "MySqlDatabase"
  context      = "Database"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  subscription = "DSP Sub - QA"
}

diagnostics_storage_account    = "eundsqastgsh"
diagnostics_storage_account_rg = "EUN-DS-QA-STG-SH"

# MySQL Database for fhr

fhr_server_name                         = "eundsqasqlfhr"
fhr_database_names                      = ["eundsqasqlfhr"]
fhr_administrator_login_name            = "mysqladmin"
fhr_mysql_admin_azure_ad_user           = "eunqamysqladminfhr@surgicalnet.io"
fhr_administrator_login_password        = null
fhr_allowed_subnet_names                = ["FHR"]
fhr_sku_name                            = "GP_Gen5_4"
fhr_mysql_version                       = 5.7
fhr_storage_mb                          = 5120
fhr_backup_retention_days               = 30
fhr_geo_redundant_backup_enabled        = true
fhr_geo_redundant_backup                = "Disabled"
fhr_auto_grow_enabled                   = true
fhr_auto_grow                           = "Disabled"
fhr_private_endpoint_connection_enabled = true
fhr_ssl_minimal_tls_version             = "TLS1_2"
fhr_infrastructure_encryption_enabled   = true

fhr_firewall_rules = {
  "default" = {
    name             = "FHR"
    start_ip_address = "0.0.0.0"
    end_ip_address   = "0.0.0.0"
  }
}

fhr_mysql_configurations = {
  interactive_timeout = "600"
}

private_endpoints = {
  pe1 = {
    resource_name            = "mysql02"
    name                     = "eundsqasqlfhr-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["mysqlServer"]
    dns_zone_name            = "privatelink.mysql.database.azure.com"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqasqlfhr"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}


