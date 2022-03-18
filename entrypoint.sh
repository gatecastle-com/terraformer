#!/bin/sh
# Entrypoint for the terraformer container to fetch the module code
# and execute it.

set -e

# Locals
__TF_VAR_FILE_OPTION="-var-file"
__TF_WORKING_DIR_OPTION="-chdir"

# Required
# TF_MODULE_REPOSITORY - repository path to clone the content of the module
# TF_COMMAND - terraform command to run eg. `plan`, `apply`, etc...

if [[ -z "${TF_MODULE_REPOSITORY}"  ]]; then
    echo "TF_MODULE_REPOSITORY environmental variable is required."
    exit -1
fi

if [[ -z "${TF_COMMAND}"  ]]; then
    echo "TF_COMMAND environmental variable is required."
    exit -1
fi


# Defaults
_TF_EXECUTABLE="${TF_EXECUTABLE:-terraform}"
_TF_MODULE_LOCATION="${TF_MODULE_LOCATION:-/module}"
_TF_VAR_FILE_PATH="${TF_VAR_FILE_PATH:-/config/terraform.tfvars}"

git clone $TF_MODULE_REPOSITORY $_TF_MODULE_LOCATION
ls /module

$_TF_EXECUTABLE $__TF_WORKING_DIR_OPTION=$_TF_MODULE_LOCATION $TF_COMMAND $__TF_VAR_FILE_OPTION=$_TF_VAR_FILE_PATH 

exec "$@"
