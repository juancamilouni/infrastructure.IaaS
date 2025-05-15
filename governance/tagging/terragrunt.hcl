
locals {
  common_vars = yamldecode(file("../../common_vars.yaml"))
}



terraform {
  source = "git::_git/ModulesCvu.infrastructure.IaaS//governance/tagging?ref=tagging-v0.0.3"
}


inputs = {
  management_group_name = "grupo-admin-cvu"  
  subscription_id       = local.common_vars.azure.subscription_id
  tenant_id             = local.common_vars.azure.tenant_id
  location              = local.common_vars.azure.global_region
}