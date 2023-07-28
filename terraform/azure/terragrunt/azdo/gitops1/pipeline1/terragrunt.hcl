locals {
  platform_config = yamldecode(file(format("%s/%s", get_env("MAIN_CONFIG_PATH"), get_env("MAIN_CONFIG_FILE_NAME"))))
  env_config      = yamldecode(file(format("%s/%s", get_env("ORCHESTRATION_PATH"), get_env("ENV_CONFIG_FILE_NAME"))))
  subscription_id = local.platform_config.subscriptions.prod_workloads[0].id # This is the line to update to point to the proper sub
}

dependency proj_repo {
  config_path = "../proj1"
   skip_outputs = true
}

terraform {
  source = "../../../../modules/azdo_pipeline"
}


inputs = {
  project_name = local.env_config.projects.project1.name
  pipelines=local.env_config.projects.project1.pipelines
}


generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">=0.7.0"
    }
  }
}

provider "azuredevops" {
  # Configuration options
}

EOF
}

include {
  path = find_in_parent_folders()
}
