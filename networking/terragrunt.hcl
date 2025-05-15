locals {
  common_vars = yamldecode(file("../common_vars.yaml"))
}



terraform {
  source = "git::https:_git/ModulesCvu.infrastructure.IaaS//networking?ref=networking-v0.0.2"
}

inputs = {
  vnet_name           = "${local.common_vars.project_name}-networking"
  location             = local.common_vars.azure.region
  resource_group_name   = "${local.common_vars.resource_group}"
  subscription_id     = local.common_vars.azure.subscription_id
  tenant_id           = local.common_vars.azure.tenant_id

  address_space = ["192.168.1.0/24"]

  subnets = [
    {
      name             = "subnet-dc"
      address_prefixes = ["192.168.1.0/27"] 
    },
    {
      name             = "subnet-app"
      address_prefixes = ["192.168.1.32/27"]
    },
    {
      name             = "subnet-db"
      address_prefixes = ["192.168.1.64/26"]  
    },
    {
      name             = "subnet-admin"
      address_prefixes = ["192.168.1.128/27"] 
    }
  ]

  gateway_subnet_prefix = "192.168.1.224/27"  # Reservada para la VPN

  tags = {
    Environment = "mig"
    Owner       = "infraestructura"
  }
}


