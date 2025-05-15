
locals {
  common_vars = yamldecode(file("../../common_vars.yaml"))
}



terraform {
  source = "git::https://Cvu1:7hEKUBJiemEGFgQxuwaX6InsHXagCx2VhXOZ886JiBEoyfTfeeN6JQQJ99BEACAAAAAX0UalAAASAZDO2HkO@dev.azure.com/Cvu1/Cvu/_git/ModulesCvu.infrastructure.IaaS//governance/location?ref=location-v0.0.2"
}


inputs = {
  scope           = "/subscriptions/${local.common_vars.azure.subscription_id}"
  subscription_id = local.common_vars.azure.subscription_id
  tenant_id       = local.common_vars.azure.tenant_id
}
