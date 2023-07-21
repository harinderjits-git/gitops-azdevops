

locals {
  env_config      = yamldecode(file(format("%s/%s", get_env("MAIN_CONFIG_PATH"), get_env("ENV_CONFIG_FILE_NAME"))))
  environment = local.env_config.prod_workloads.prd
  subscription_id = local.env_config.subscriptions.prod_workloads[0].id 
}

terraform {
  source = "../../../modules/storageaccountmodule"

  extra_arguments "force_subscription" {
    commands = [
      "init",
      "apply",
      "destroy",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint"
    ]
    env_vars = {
      ARM_SUBSCRIPTION_ID = local.env_config.subscriptions.prod_workloads[0].id
    }
  }
}


inputs = {
 # location = local.env_config.global.locations[0]
  tags     = merge(local.env_config.global.tags, local.environment.tags)
  name = local.env_config.global.remote_state.storage_account
  resource_group_name = local.env_config.global.remote_state.rg_name
  container_name            = local.env_config.global.remote_state.container_name
}

# Generate a special provider.tf to address the generation of dual provider configuration because
# the vnets are in different subscriptions
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

EOF
}


include {
  path = find_in_parent_folders()
}
