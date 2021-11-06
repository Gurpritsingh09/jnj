# common values
resource-group-name = "EUN-DS-QA-AZF-DVC"
# location            = "northeurope"

tags = {
  environment  = "QA"
  region       = "eun"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  team         = "Device"
  application  = "Device"
  dsep_version = "2.0"
  subscription = "Digital Surgery Platform QA EUN"
}

# AppService Plan specific values
app-service-plan-name = "EUN-DS-QA-ASP-DVC"
sku = {
  sku1 = {
    tier     = "PremiumV3"
    size     = "P1v3"
    capacity = 1
  }
}
# kind     = "FunctionApp"
kind     = "linux"
reserved = true

# # Azure Function specific values
functions = {
  function1 = {
    name    = "EUN-DS-QA-FUNC-DVC-PROVISION"
    version = "~3"
    os-type = "linux" # "windows"
  },
  function2 = {
    name    = "EUN-DS-QA-FUNC-DVC-PACKAGE"
    version = "~3"
    os-type = "linux" # "windows"
  },
  function3 = {
    name    = "EUN-DS-QA-FUNC-DVC-SECRET"
    version = "~3"
    os-type = "linux" # "windows"
  },
  function4 = {
    name    = "EUN-DS-QA-FUNC-DVC-CERTIFICATE"
    version = "~3"
    os-type = "linux" # "windows"
  }
}

# data lookup values
subnet-name = "DVC-AZF"
vnet-name   = "DS-QA-VNET"
network-rg  = "EUN-DS-QA-NWK-SH"

appinsights-name = "EUN-DS-QA-APPIN-DVC"

sa-name = "eundsqastgdvc"
sa-rg   = "EUN-DS-QA-STG-DVC"

uaid-name = "eun-ds-qa-function-identity-dvc"
