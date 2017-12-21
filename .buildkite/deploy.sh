#!/bin/bash

set -eo pipefail
echo "--- Deploy to $BUILDKITE_BRANCH"
gulp deploy
buildkite-agent artifact upload "zip/**/*.zip"