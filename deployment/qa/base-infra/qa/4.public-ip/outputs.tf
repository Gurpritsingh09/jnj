
output "ds-npd-prm-fw-pip" {
  value = module.ds-qa-prm-fw-pip.public_ip
}


output "tf-test-vpn-pip" {
  value = module.ds-qa-vpn-pip.public_ip
}

