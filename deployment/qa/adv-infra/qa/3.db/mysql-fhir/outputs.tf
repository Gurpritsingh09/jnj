
# Outputs for FHR QA DB 
output "tf_test_fhr_mysql_server_name" {
  value = module.FHRQAMySqlDatabase.mysql_server_name
}
output "tf_test_fhr_mysql_databases_names" {
  value = module.FHRQAMySqlDatabase.mysql_databases_names
}
output "tf_test_fhr_admin_username" {
  value = module.FHRQAMySqlDatabase.admin_username
}
output "tf_test_fhr_mysql_version" {
  value = module.FHRQAMySqlDatabase.mysql_version
}
