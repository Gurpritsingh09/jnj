output "network_security_group_ids" {
  value = module.BaseInfrastructure.network_security_group_ids
}
output "map_vnets" {
  value = module.BaseInfrastructure.map_vnets
}
output "map_subnets" {
  value = module.BaseInfrastructure.map_subnets
}
output "subnets_with_serviceendpoints" {
  value = module.BaseInfrastructure.subnets_with_serviceendpoints
}