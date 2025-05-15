locals {
  common_vars = yamldecode(file("../common_vars.yaml"))
}

terraform {
  source = "git::https://Cvu1:7hEKUBJiemEGFgQxuwaX6InsHXagCx2VhXOZ886JiBEoyfTfeeN6JQQJ99BEACAAAAAX0UalAAASAZDO2HkO@dev.azure.com/Cvu1/Cvu/_git/ModulesCvu.infrastructure.IaaS//identity?ref=identity-v0.0.2"
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
