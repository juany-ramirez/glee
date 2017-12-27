#!/bin/bash

set -eo pipefail
echo "--- Init Terraform Backend"
cd terraform/aws/backend
terraform init -input=false
echo "--- Create Workspace for $ENVIRONMENT"
set +e
terraformmessage=$(terraform workspace new $ENVIRONMENT 2>/dev/null)
echo $?
set -e
if [ "$terraformmessage" == "Workspace \"$ENVIRONMENT\" already exists" ]; then
   echo "Workspace $ENVIRONMENT already exists"
   exit 0
else
  echo $terraformmessage
  #exit 1
fi

