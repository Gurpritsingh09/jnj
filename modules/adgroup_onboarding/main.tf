data "azuread_group" "ad_groups" {
  for_each = toset(var.adgroups)
  display_name     = each.value
}

resource "azuread_group_member" "example" {
  for_each = data.azuread_group.ad_groups
  group_object_id  = each.value["id"]
  member_object_id = var.member_object_id
}