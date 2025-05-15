locals {
  common_vars = yamldecode(file("../common_vars.yaml"))
}

terraform {
  source = "git::_git/ModulesCvu.infrastructure.IaaS//keyvault?ref=key-v0.0.6"
}

dependency "identity" {
  config_path = "../identity"
}

inputs = {
  name                = "kv-${local.common_vars.project_name}"
  location             = local.common_vars.azure.region
  resource_group_name   = "${local.common_vars.resource_group}"
  subscription_id     = local.common_vars.azure.subscription_id
  tenant_id           = local.common_vars.azure.tenant_id

  # Se inyecta automáticamente desde el módulo identity
  object_id = dependency.identity.outputs.uami_principal_id

  tags = {
    Environment = "mig"
    Owner       = "infraestructura"
  }
}
