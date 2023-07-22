terraform {
  backend "azurerm" {
    resource_group_name  = "harinderjit.singh-RG"
    storage_account_name = "remotestaterg2023071"
    container_name       = "tfstateapp1"
    key                  = "terraform.tfstate"
    tenant_id            = "532add52-c73b-4e6a-a87e-03b5683cdc67"
    subscription_id      = "1a7ccac9-09f1-4c57-a2d9-b76fcbf638a3"
  }
}
