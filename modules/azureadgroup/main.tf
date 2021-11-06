

resource "azuread_group" "dsp_ad_groups" {
  for_each = toset(var.azuread_security_groups)
  name     = each.value
}
