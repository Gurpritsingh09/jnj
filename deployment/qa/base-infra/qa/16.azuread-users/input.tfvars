adusers = [{
  user_principal_name = "EUNQAMYSQLADMINFHR@surgicalnet.io"
  display_name        = "Terraform provisioned sql admin for FHR"

  },
  {
    user_principal_name = "EUNQAMYSQLADMINDATA@surgicalnet.io"
    display_name        = "Terraform provisioned sql admin for DATA"

  },
  {
    user_principal_name = "EUNQAMYSQLADMINVELYS@surgicalnet.io"
    display_name        = "Terraform provisioned sql admin for VELYS"

}]


keyvault_name = "EUN-DS-QA-VLT"
keyvault_rg   = "EUN-DS-QA-KEY-SH"
mfa_ad_group  = "MFA_Exempt"
