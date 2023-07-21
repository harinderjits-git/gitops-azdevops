locals {
  yaml_rg= yamldecode(file("${path.module}/../terragrunt/orchestration/config_env_sampleapp.yaml"))
}



module "storageaccount" {
  source                   = "../modules/storageaccountmodule"
  name                     = local.yaml_rg.global.remote_state.storage_account
  account_replication_type = "LRS"
  tags = local.yaml_rg.global.tags
  container_name = local.yaml_rg.global.remote_state.container_name
  resource_group_name = local.yaml_rg.global.remote_state.rg_name
}
