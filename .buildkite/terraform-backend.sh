#!/bin/bash

set -eo pipefail
echo "--- Init Terraform Backend"
cd terraform/aws/backend
terraform init -input=false
echo "--- Create Workspace for $ENVIRONMENT"
set +e
terraformmessage=$(terraform workspace new $ENVIRONMENT 2>&1 1>/dev/null)
set -e
if [ $? -eq 0 ]; then
   echo $terraformmessage
   exit 0
else
  echo $?  
  if [[ $terraformmessage == "already exists" ]]; then
    echo "GOOOD TO GO!!! $terraformmessage"
    exit 0
  else
    echo "ERROR!!!! $terraformmessage"
    exit $?  
  fi
fi

