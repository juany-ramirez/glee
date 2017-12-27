#!/bin/bash

set -eo pipefail
echo "--- Init Terraform Backend"
terraform init -input=false aws/backend