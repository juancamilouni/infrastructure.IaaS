locals {
  common_vars = yamldecode(file("../common_vars.yaml"))
}


terraform {
  source = "git::https://github.com/juancamilouni/Modules.infrastructure.git//resource_group?ref=resource_group-v0.0.1"
}


inputs = {
  subscription_id     = local.common_vars.azure.subscription_id
  tenant_id           = local.common_vars.azure.tenant_id
  location            = local.common_vars.azure.region
  resource_group_name = "${local.common_vars.project_name}-rg"
}
