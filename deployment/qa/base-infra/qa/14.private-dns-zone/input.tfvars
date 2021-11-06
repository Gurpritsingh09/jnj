resource_group_name = "EUN-DS-QA-NWK-SH"
dns_zone_name       = "qa.eun.surgicalnet.io"
zone_to_vnet_links = [{
  vn_name              = "DS-QA-VNET"
  vn_rg                = "EUN-DS-QA-NWK-SH"
  registration_enabled = false
  },
  {
    vn_name              = "DS-QA-PRM-VNET"
    vn_rg                = "EUN-DS-QA-NWK-SH"
    registration_enabled = false
}]
tags = {
  environment = "qa"
  owner       = "Infra Team"
  created-by  = "Terraform Provisioned"
}
apigee_dns_record_name = "api-qa"
apigee_dns_record_url  = "jnj-md-dsp-qa.apigee.net"
