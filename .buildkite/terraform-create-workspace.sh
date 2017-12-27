#!/bin/bash

set -eo pipefail
set +e
terraformmessage=$(terraform workspace new $ENVIRONMENT 2>&1 1>/dev/null)
terraformstatuscode=$?
set -e
if [ $terraformstatuscode -eq 0 ]; then
   echo $terraformstatuscode
   echo "$terraformmessage"
   exit 0
else
  REGEX="already exists"  
  if [[ $terraformmessage =~ $REGEX ]]; then
    echo "GOOD TO GO -> $terraformmessage"
    exit 0
  else
    echo "$terraformmessage"
    exit $terraformstatuscode  
  fi
fi
