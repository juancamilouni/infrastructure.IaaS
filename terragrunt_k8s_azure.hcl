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

generate "vars" {
  path      = "var_commons.tf"
  if_exists = "overwrite"
  contents  = <<EOF
variable "host" {}
variable "cluster_ca_certificate" {}
variable "token" {}
variable "cluster_name" {}
EOF
}

generate "versions" {
  if_exists = "overwrite"
  path      = "required_versions.tf"
  contents  = <<EOF
provider "kubernetes" {
  host                   = var.host
  cluster_ca_certificate = var.cluster_ca_certificate
  token                  = var.token
}

provider "helm" {
  kubernetes {
    host                   = var.host
    cluster_ca_certificate = var.cluster_ca_certificate
    token                  = var.token
  }
}
EOF
}
