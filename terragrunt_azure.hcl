locals {
  common_vars = yamldecode(file("common_vars.yaml"))
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider_azure.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "azurerm" {
  features {}

  subscription_id = local.common_vars.azure.subscription_id
  tenant_id       = local.common_vars.azure.tenant_id
}
EOF
}
