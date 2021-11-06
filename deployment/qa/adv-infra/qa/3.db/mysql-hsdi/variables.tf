
# MySQL Database

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "diagnostics_storage_account" {
  type        = string
  description = "destination account to store audit logs"
}

variable "diagnostics_storage_account_rg" {
  type        = string
  description = "storage account RG for the diagnostics SA"
}

# MySQL Database for FHIR

variable "hsdi_server_name" {
  type        = string
  description = "The name of the MyQL Server"
}

variable "hsdi_database_names" {
  type        = list(string)
  description = "List of MySQL database names"
}

variable "hsdi_administrator_login_name" {
  type        = string
  description = "The administrator username of MySQL Server"
}

variable "hsdi_administrator_login_password" {
  type        = string
  description = "The administrator password of the MySQL Server"
}

variable "hsdi_allowed_subnet_names" {
  type        = list(string)
  description = "The list of subnet names that the MySQL server will be connected to"
}

variable "hsdi_sku_name" {
  type        = string
  description = "Specifies the SKU Name for this MySQL Server"
}

variable "hsdi_mysql_version" {
  type        = number
  description = "Specifies the version of MySQL to use. Valid values are 5.6, 5.7, and 8.0"
}

variable "hsdi_storage_mb" {
  type        = number
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
}

variable "hsdi_backup_retention_days" {
  type        = number
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
}

variable "hsdi_geo_redundant_backup_enabled" {
  type        = bool
  description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier."
}

variable "hsdi_geo_redundant_backup" {
  type        = string
  description = "Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier."
}

variable "hsdi_auto_grow_enabled" {
  type        = bool
  description = "Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true."
}

variable "hsdi_auto_grow" {
  type        = string
  description = "(Optional) Defines whether autogrow is enabled or disabled for the storage. Valid values are Enabled or Disabled."
}

variable "hsdi_mysql_configurations" {
  type        = map(any)
  description = "Map of MySQL configuration settings to create. Key is name, value is server parameter value"
}

variable "hsdi_ssl_minimal_tls_version" {
  type        = string
  description = "The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLSEnforcementDisabled."
}

variable "hsdi_infrastructure_encryption_enabled" {
  type        = bool
  description = "Whether or not infrastructure is encrypted for this server. Defaults to false. Changing this forces a new resource to be created."
}

variable "hsdi_firewall_rules" {
  type = map(object({
    name             = string # (Required) Specifies the name of the MySQL Firewall Rule. 
    start_ip_address = string # (Required) The starting IP Address to allow through the firewall for this rule
    end_ip_address   = string # (Required) The ending IP Address to allow through the firewall for this rule
  }))
  description = "List of MySQL Server firewall rule specification"
  default     = {}
}

variable "hsdi_private_endpoint_connection_enabled" {
  type        = bool
  description = "Specify if only private endpoint connections will be allowed to access this resource"
}

# Private Endpoint
variable "pe_resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "private_endpoints" {
  type = any
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "hsdi_mysql_admin_azure_ad_user" {
  type        = string
  description = "The administrator azure AD user of FHR MySQL Server"
}

