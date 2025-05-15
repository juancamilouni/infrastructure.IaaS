locals {
  common_vars = yamldecode(file("../common_vars.yaml"))
}

dependency "networking" {
  config_path = "../networking"
}

terraform {
  source = "git::https://Cvu1:7hEKUBJiemEGFgQxuwaX6InsHXagCx2VhXOZ886JiBEoyfTfeeN6JQQJ99BEACAAAAAX0UalAAASAZDO2HkO@dev.azure.com/Cvu1/Cvu/_git/ModulesCvu.infrastructure.IaaS//vpnp2s?ref=vpn-v0.0.1"
}



inputs = {
  location             = local.common_vars.azure.region
  resource_group_name   = "${local.common_vars.resource_group}"
  subscription_id     = local.common_vars.azure.subscription_id
  tenant_id           = local.common_vars.azure.tenant_id
  gateway_subnet_id   = dependency.networking.outputs.gateway_subnet_id

  tags = {
    Environment = "mig"
    Owner       = "infraestructura"
  }
}
