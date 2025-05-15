locals {
  common_vars = yamldecode(file("../common_vars.yaml"))
}

terraform {
  source = "git::_git/ModulesCvu.infrastructure.IaaS//identity?ref=identity-v0.0.2"
}

inputs = {
  name                = "uami-${local.common_vars.project_name}"
  location            = local.common_vars.azure.region
  resource_group_name   = "${local.common_vars.resource_group}"

  tags = {
    Environment = "mig"
    Owner       = "infraestructura"
  }
}
