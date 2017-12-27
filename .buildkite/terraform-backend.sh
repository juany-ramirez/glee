#!/bin/bash

set -eo pipefail
echo "--- Init Terraform Backend"
ls -a
terraform init -input=false aws/backend