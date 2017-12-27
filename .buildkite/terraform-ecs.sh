#!/bin/bash

set -eo pipefail
echo "--- Init Terraform Backend"
cd terraform/aws/ecs
terraform init -input=false
echo "--- Create Workspace for $ENVIRONMENT"
./.buildkite/terraform-create-workspace.sh
echo "--- Select Workspace for $ENVIRONMENT"
terraform workspace select $ENVIRONMENT


