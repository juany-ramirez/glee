#!/bin/bash

set -eo pipefail
echo "--- Init Terraform Backend"
ls -a terraform/aws/backend
terraform init -input=false teraform/aws/backend