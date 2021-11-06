# MySQL Database

resource_group_name    = "EUN-DS-QA-SQL-VELYS"
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


# Shared MySQL database for QA

server_name                         = "eundsqasqlvelys"
database_names                      = ["eundsqasqlvelys"]
administrator_login_name            = "mysqladmin"
administrator_login_password        = null
mysql_admin_azure_ad_user           = "eunqamysqladminvelys@surgicalnet.io"
allowed_subnet_names                = ["AKS"]
sku_name                            = "GP_Gen5_4"
mysql_version                       = 5.7
storage_mb                          = 5120
backup_retention_days               = 30
geo_redundant_backup_enabled        = true
geo_redundant_backup                = "Disabled"
auto_grow_enabled                   = true
auto_grow                           = "Disabled"
private_endpoint_connection_enabled = true
ssl_minimal_tls_version             = "TLS1_2"
infrastructure_encryption_enabled   = true

firewall_rules = {
  "default" = {
    name             = "AKS"
    start_ip_address = "0.0.0.0"
    end_ip_address   = "0.0.0.0"
  }
}

mysql_configurations = {
  interactive_timeout  = "600"
  character_set_server = "UTF8MB4"
  collation_server     = "UTF8MB4_UNICODE_CI"
  audit_log_enabled    = "ON"
  audit_log_events     = "CONNECTION,DCL,DML"
}

diagnostics_storage_account    = "eundsqastgsh"
diagnostics_storage_account_rg = "EUN-DS-QA-STG-SH"

#  Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "mysql01"
    name                     = "eundsqasqlvelys-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["mysqlServer"]
    dns_zone_name            = "privatelink.mysql.database.azure.com"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqasqlvelys"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}


