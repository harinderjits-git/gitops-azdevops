#!/bin/bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
 find . -name .terragrunt-cache -type d -exec rm -rf {} +
 find . -name .terraform -type d -exec rm -rf {} +
## EDIT VALUES BELOW (IF NEEDED) for the ./set-env.sh file generated by
# make setup-set-env

# Assumes logged in to the core platform subscription

# Assumes logged in to the core platform subscription
export ENV_CONFIG_FILE_NAME=config_env_sampleapp.yaml
# export TENANT_ID=$(az account show --query tenantId -o tsv)
# export BOOTSTRAP_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
export ORCHESTRATION_PATH=${THIS_DIR}/orchestration
export MAIN_CONFIG_PATH=${THIS_DIR}/orchestration
export RUN_INIT_DIR=${THIS_DIR}/run_init
export MAIN_CONFIG_FILE_NAME=config_main.yaml
export REMOTE_STATE_FILE_NAME=config_remote_state.yaml
#export AD_GROUPS_FILE_NAME=config_main_ad_groups.yaml
#export ALLOW_LIST_CONFIG_FILE_NAME=config_sourcedvpn_allowlist.yaml
## EDIT VALUE ABOVE


# Check for BOOTSTRAP_SUBSCRIPTION_ID
if [ -z "${BOOTSTRAP_SUBSCRIPTION_ID}" ]; then
		echo 'BOOTSTRAP_SUBSCRIPTION_ID is not set.'
		exit 1;
fi

if [ -z "${TENANT_ID}" ]; then
		echo 'TENANT_ID is not set.'
		exit 1;
fi
echo ${TENANT_ID}
echo ${BOOTSTRAP_SUBSCRIPTION_ID}
echo ${MAIN_CONFIG_PATH}

# echo "INFO - Unsetting ARM_* environment variables"
# unset ARM_TENANT_ID
# unset ARM_SUBSCRIPTION_ID
# unset ARM_CLIENT_ID
# unset ARM_CLIENT_SECRET

#echo "INFO - Configuring service principal authentication"
# ARM_CLIENT_ID=$(ARM_CLIENT_ID)
# ARM_CLIENT_SECRET=$(ARM_CLIENT_SECRET)
#ARM_TENANT_ID=${TENANT_ID}
# export ARM_CLIENT_ID
# export ARM_CLIENT_SECRET
#export ARM_TENANT_ID
