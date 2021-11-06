# MySQL Database

resource_group_name    = "EUN-DS-QA-SQL-HSDI"
pe_resource_group_name = "EUN-DS-QA-NWK-SH"

tags = {
  source       = "terraform"
  environment  = "qa"
  service      = "MySqlDatabase"
  context      = "Database"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "HSDI"
  application  = "Orthanc, Dicom"
  dsep_version = "2.0"
  subscription = "DSP Sub - QA"
}

hsdi_mysql_configurations = {
  interactive_timeout             = "600"
  character_set_server            = "UTF8MB4"
  collation_server                = "UTF8MB4_UNICODE_CI"
  audit_log_enabled               = "ON"
  audit_log_events                = "CONNECTION,DCL,DML"
  wait_timeout                    = "14400"
  log_bin_trust_function_creators = "ON"
}

diagnostics_storage_account    = "eundsqastgsh"
diagnostics_storage_account_rg = "EUN-DS-QA-STG-SH"

# MySQL Database for DVC

hsdi_server_name                         = "eundsqasqlhsdi"
hsdi_database_names                      = ["eundsqasqlhsdi"]
hsdi_administrator_login_name            = "mysqladmin"
hsdi_mysql_admin_azure_ad_user           = "eunqamysqladminhsdi@surgicalnet.io"
hsdi_administrator_login_password        = null
hsdi_allowed_subnet_names                = ["HSDI"]
hsdi_sku_name                            = "GP_Gen5_4"
hsdi_mysql_version                       = 5.7
hsdi_storage_mb                          = 5120
hsdi_backup_retention_days               = 30
hsdi_geo_redundant_backup_enabled        = true
hsdi_geo_redundant_backup                = "Disabled"
hsdi_auto_grow_enabled                   = true
hsdi_auto_grow                           = "Disabled"
hsdi_private_endpoint_connection_enabled = true
hsdi_ssl_minimal_tls_version             = "TLS1_2"
hsdi_infrastructure_encryption_enabled   = true

hsdi_firewall_rules = {
  "default" = {
    name             = "HSDI"
    start_ip_address = "0.0.0.0"
    end_ip_address   = "0.0.0.0"
  }
}

# hsdi_mysql_configurations = {
#   interactive_timeout = "600"
# }

#  Private Endpoint

private_endpoints = {
  pe1 = {
    resource_name            = "mysql03"
    name                     = "eundsqasqlhsdi-pe"
    approval_required        = false
    approval_message         = null
    group_ids                = ["mysqlServer"]
    dns_zone_name            = "privatelink.mysql.database.azure.com"
    zone_exists              = true
    zone_to_vnet_link_exists = true
    registration_enabled     = true
    dns_a_records = [{
      name                  = "eundsqasqlhsdi"
      ttl                   = 300
      ip_addresses          = null
      private_endpoint_name = null
    }]
  }
}
