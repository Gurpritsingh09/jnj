resource_group_name = "EUN-DS-QA-NWK-SH"

agw_private_ip = "10.190.227.4"

application_gateways = {
  "appgw1" = {
    name    = "DS-QA-AGWY"
    zones   = ["1", "2", "3"]
    waf_key = "waf1"
    sku = {
      name     = "WAF_v2"
      tier     = "WAF_v2"
      capacity = 2
    }
    gateway_ip_configurations = [{
      name = "my-gateway-ip-configuration"
    }]
    frontend_ports = [
      {
        name = "dp-feport"
        port = 443
      }
    ]
    #frontend_ip_configurations = [
    #  {
    #    name             = "dp-feip"
    #    static_ip        = null
    #    enable_public_ip = true
    #  }
    #]

    backend_address_pools = [
      #{
      #  name         = "sysdig"
      #  fqdns        = null
      #  ip_addresses = null
      #},
      {
        name         = "QA_Validation_Backend"
        fqdns        = null
        ip_addresses = null
      }
    ]
    backend_http_settings = [
      #{
      #  name                  = "sysdig"
      #  path                  = "/"
      #  port                  = 443
      #  cookie_based_affinity = "Enabled"
      #  request_timeout       = null
      #  probe_name            = "sysdig"
      #  host_name             = "sysdig.qa.thesurgicalnet.io"
      #},
      {
        name                  = "QA_Validation_Multi"
        path                  = "/"
        port                  = 443
        cookie_based_affinity = "Enabled"
        request_timeout       = null
        probe_name            = "QA_Validation_Multi"
        host_name             = "val.api-qa-validation.qa.eun.surgicalnet.io"
      }
    ]
    http_listeners = [
      #{
      #  name                           = "sysdig"
      #  frontend_ip_configuration_name = "dp-feip"
      #  frontend_port_name             = "dp-feport"
      #  ssl_certificate_name           = "Sectigo.pfx"
      #  sni_required                   = true
      #  listener_type                  = "MultiSite"
      #  host_name                      = "sysdig.qa.surgicalnet.io"
      #},
      {
        name                           = "QA_Validation_Multi"
        frontend_ip_configuration_name = "feip-private"
        frontend_port_name             = "dp-feport"
        ssl_certificate_name           = "Sectigo.pfx"
        sni_required                   = true
        listener_type                  = "MultiSite"
        host_name                      = "val.api-qa-validation.qa.eun.surgicalnet.io"
      }
    ]
    request_routing_rules = [
      #{
      #  name                        = "sysdig"
      #  rule_type                   = "Basic"
      #  listener_name               = "sysdig"
      #  backend_address_pool_name   = "sysdig"
      #  backend_http_settings_name  = "sysdig"
      #  redirect_configuration_name = null
      #  url_path_map_name           = null
      #},
      {
        name                        = "QA_Validation_Multi"
        rule_type                   = "Basic"
        listener_name               = "QA_Validation_Multi"
        backend_address_pool_name   = "QA_Validation_Backend"
        backend_http_settings_name  = "QA_Validation_Multi"
        redirect_configuration_name = null
        url_path_map_name           = null
      }
    ]
    url_path_maps = null

    probes = [
      #{
      #  name                = "sysdig"
      #  path                = "/"
      #  host                = "sysdig.qa.surgicalnet.io"
      #  interval            = "30"
      #  timeout             = "30"
      #  unhealthy_threshold = "3"
      #},
      {
        name                = "QA_Validation_Multi"
        path                = "/"
        host                = "val.api-qa-validation.qa.eun.surgicalnet.io"
        interval            = "30"
        timeout             = "30"
        unhealthy_threshold = "3"
      }
    ]
    redirect_configuration   = null
    ssl_certificate_name     = "Sectigo.pfx"
    ssl_certificate_path     = "//12.appgwy//certificates//Sectigo.pfx"
    ssl_certificate_password = "sectigo"
    disabled_ssl_protocols   = null
  }
}

waf_policies = {
  "waf1" = {
    name = "dsp-wafpolicy"
    custom_rules = [{
      name      = "Rule1"
      priority  = 1
      rule_type = "MatchRule"
      action    = "Block"
      match_conditions = [{
        match_variables = [{
          variable_name = "RemoteAddr"
          selector      = null
        }]
        operator           = "IPMatch"
        negation_condition = false
        match_values       = ["10.190.0.0/16", "172.27.0.0/16"]
      }]
    }]
    policy_settings = {
      enabled = false
      mode    = "Prevention"
    }
    managed_rules = {
      exclusions = [{
        match_variable          = "RequestHeaderNames"
        selector                = "x-company-secret-header"
        selector_match_operator = "Equals"
      }]
      managed_rule_sets = [{
        type    = "OWASP"
        version = "3.1"
        rule_group_overrides = [{
          rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
          disabled_rules  = ["920300", "920440"]
        }]
      }]
    }
  }
}

tags = {
  source       = "terraform"
  environment  = "qa"
  application  = "DS"
  service      = "Application Gateway"
  context      = "Application Gateway"
  owner        = "Infra Team"
  created-by   = "Terraform Provisioned"
  subscription = "DSP Sub - QA"
}
