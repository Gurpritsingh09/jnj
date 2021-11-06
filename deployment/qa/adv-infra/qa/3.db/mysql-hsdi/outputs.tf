output "tf_test_hsdi_mysql_server_name" {
  value = module.HSDIQAMySqlDatabase.mysql_server_name
}
output "tf_test_hsdi_mysql_databases_names" {
  value = module.HSDIQAMySqlDatabase.mysql_databases_names
}
output "tf_test_hsdi_admin_username" {
  value = module.HSDIQAMySqlDatabase.admin_username
}
output "tf_test_hsdi_mysql_version" {
  value = module.HSDIQAMySqlDatabase.mysql_version
}
