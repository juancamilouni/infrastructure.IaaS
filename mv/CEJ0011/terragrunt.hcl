locals {
  common_vars = yamldecode(file("../../common_vars.yaml"))
  cloud_init_cpu_limit = filebase64("${path_relative_from_include()}/cloud-init/limit-6cpus.yml")
}

dependency "networking" {
  config_path = "../../networking"
}

dependency "management" {
  config_path = "../../management"
}

terraform {
  source = "git::_git/ModulesCvu.infrastructure.IaaS//mv/CEJ0011?ref=CEJ0011-v0.0.6"
}



inputs = {
  vm_name                     = "CEJ0011"
  vm_size                     = "Standard_F8s_v2"
  location                    = local.common_vars.azure.region
  resource_group_name         = local.common_vars.resource_group
  subscription_id             = local.common_vars.azure.subscription_id
  tenant_id                   = local.common_vars.azure.tenant_id

  # RED Tomamos la subred por nombre usando el output que ya tienes
  subnet_id                   = dependency.networking.outputs.subnet_ids["subnet-db"]
  private_ip                  = "192.168.1.105"

  # También desde outputs de management
  log_analytics_workspace_id  = dependency.management.outputs.workspace_id
  

  admin_username              = local.common_vars.vm_admin.username
  ssh_public_key              = local.common_vars.vm_admin.ssh_public_key

  custom_data = local.cloud_init_cpu_limit



  # Disco
  os_disk_size_gb      = 128
  data_disk_sizes      = [512, 128]

  tags = {
    Environment = "mig"
    Owner       = "infraestructura"
  }
}

