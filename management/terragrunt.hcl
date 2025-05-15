locals {
  common_vars = yamldecode(file("../common_vars.yaml"))
}

terraform {
  source = "git::https:/_git/ModulesCvu.infrastructure.IaaS//management?ref=management-v0.0.4"
}

inputs = {
  project_name         = local.common_vars.project_name
  location             = local.common_vars.azure.region
  resource_group_name   = "${local.common_vars.resource_group}"
  subscription_id     = local.common_vars.azure.subscription_id
  tenant_id           = local.common_vars.azure.tenant_id

  tags = {
    Environment = "mig"
    Owner       = "infraestructura"
  }
}

