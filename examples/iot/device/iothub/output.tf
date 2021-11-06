output "iot_hub" {
  value = module.iot_hub.iot_hub
}

output "tf_test_iot_hub_name" {
  value = module.iot_hub.iot_hub_name
}

output "tf_test_iot_hub_resource_group_name" {
  value = module.iot_hub.iot_hub_resource_group_name
}

output "tf_test_iot_hub_location" {
  value = module.iot_hub.iot_hub_location
}

output "tf_test_iot_hub_pricing" {
  value = module.iot_hub.iot_hub_pricing
}

output "iot_hub_scale" {
  value = module.iot_hub.iot_hub_scale
}

output "tf_test_iot_hub_message_endpoints" {
  value = toset([
    for endpoint in module.iot-hub-endpoint : endpoint.iot_hub_messaging_endpoint
  ])
}

output "tf_test_iot_hub_message_routes" {
  value = toset([
    for route in module.iot-hub-endpoint : route.iot_hub_messaging_route
  ])
}

output "tf_test_iot_hub_message_routing_queries" {
  value = toset([
    for route in module.iot-hub-endpoint : route.iot_hub_messaging_routing_query
  ])
}
