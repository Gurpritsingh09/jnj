# MySQL Database

resource_group_name    = "EUN-DS-QA-SQL-DATA"
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

# MYSQL Database for Airflow Metadata

aflm_server_name                         = "eundsqasqldata"
aflm_database_names                      = ["eundsqasqldata"]
aflm_administrator_login_name            = "mysqladmin"
aflm_mysql_admin_azure_ad_user           = "eunqamysqladmindata@surgicalnet.io"
aflm_administrator_login_password        = null
aflm_allowed_subnet_names                = ["DATA"]
aflm_sku_name                            = "GP_Gen5_4"
aflm_mysql_version                       = 5.7
aflm_storage_mb                          = 5120
aflm_backup_retention_days               = 30
aflm_geo_redundant_backup_enabled        = true
aflm_geo_redundant_backup                = "Disabled"
aflm_auto_grow_enabled                   = true
aflm_auto_grow                           = "Disabled"
aflm_private_endpoint_connection_enabled = true
aflm_ssl_minimal_tls_version             = "TLS1_2"
aflm_infrastructure_encryption_enabled   = true

aflm_firewall_rules = {
  "default" = {
    name             = "DATA"
    start_ip_address = "0.0.0.0"
    end_ip_address   = "0.0.0.0"
  }
}

aflm_mysql_configurations = {
  wait_timeout         = "14400"
  interactive_timeout  = "600"
  character_set_server = "UTF8MB4"
  collation_server     = "UTF8MB4_UNICODE_CI"
  audit_log_enabled    = "ON"
  audit_log_events     = "CONNECTION,DCL,DML"
}

#  Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "mysql03"
    name                     = "eundsqasqldata-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["mysqlServer"]
    dns_zone_name            = "privatelink.mysql.database.azure.com"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "eundsqasqldata"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}


