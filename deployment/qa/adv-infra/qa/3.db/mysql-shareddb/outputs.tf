# Outputs for Shared DB QA 
output "tf_test_mysql_server_name" {
  value = module.QAMySqlDatabase.mysql_server_name
}
output "tf_test_mysql_databases_names" {
  value = module.QAMySqlDatabase.mysql_databases_names
}
output "tf_test_admin_username" {
  value = module.QAMySqlDatabase.admin_username
}
output "tf_test_mysql_version" {
  value = module.QAMySqlDatabase.mysql_version
}