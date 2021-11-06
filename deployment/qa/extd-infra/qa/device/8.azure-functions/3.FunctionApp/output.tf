output "function-name" {
  value = toset([
    for function in module.AzureFunction : function.function_app_name
  ])
}

output "function-rg" {
  value = toset([
    for function in module.AzureFunction : function.function_app_rg
  ])
}

output "function-default-hostname" {
  value = toset([
    for function in module.AzureFunction : function.function_app_default_hostname
  ])
}
