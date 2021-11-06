output "iot_hub_id" {
   value=module.iot_hub.iot_hub.id
}
output "iot_consumer_group_name" {
   value=module.iot_hub.iothub_consumer_group.name
}
output "iothub_storage_account" {
   value=module.iot_hub.iothub_storage_account
}
output "iothub_storage_container" {
   value=module.iot_hub.iothub_storage_container
}
