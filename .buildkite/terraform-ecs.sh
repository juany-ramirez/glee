#!/bin/bash

set -eo pipefail
echo "--- Init Terraform Backend"
cd terraform/aws/ecs
terraform init -input=false
echo "--- Select Workspace for $ENVIRONMENT"
terraform workspace select $ENVIRONMENT


