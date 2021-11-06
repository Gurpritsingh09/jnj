# Outputs for Airflow Metadata QA
output "tf_test_aflm_mysql_server_name" {
  value = module.AirflowMetadataMySql.mysql_server_name
}
output "tf_test_aflm_mysql_databases_names" {
  value = module.AirflowMetadataMySql.mysql_databases_names
}
output "tf_test_aflm_admin_username" {
  value = module.AirflowMetadataMySql.admin_username
}
output "tf_test_aflm_mysql_version" {
  value = module.AirflowMetadataMySql.mysql_version
}
