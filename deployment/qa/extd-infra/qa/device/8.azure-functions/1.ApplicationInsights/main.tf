module "AI" {
  source               = "../../../../../../../modules/ApplicationInsights"
  resource_group_name  = var.resource_group_name
  application_insights = var.application_insights
  tags                 = var.tags
}
