#!/bin/bash
# Registers a Lifecycle Configuration Script using the AWS CLI

set -eux

export LCC_SCRIPT_NAME='install-reqs-txt'
export SCRIPT_FILE_NAME='scripts/install-requirements-txt/on-jupyter-server-start.sh'
export SCRIPT_TYPE="JupyterServer"
# export SCRIPT_TYPE="KernelGateway"

LCC_CONTENT=`openssl base64 -A -in ${SCRIPT_FILE_NAME}`

aws sagemaker create-studio-lifecycle-config \
  --studio-lifecycle-config-name $LCC_SCRIPT_NAME \
  --studio-lifecycle-config-content $LCC_CONTENT \
  --studio-lifecycle-config-app-type $SCRIPT_TYPE
