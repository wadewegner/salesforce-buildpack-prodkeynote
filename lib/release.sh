#!/usr/bin/env bash

START_TIME=$SECONDS

# set -x
set -o errexit      # always exit on error
set -o pipefail     # don't ignore exit codes when piping output
unset GIT_DIR       # Avoid GIT_DIR leak from previous build steps

TARGET_SCRATCH_ORG_ALIAS=${1:-}
SFDX_PACKAGE_VERSION_ID=${2:-}

vendorDir="vendor/sfdx"

source "$vendorDir"/common.sh
source "$vendorDir"/sfdx.sh
source "$vendorDir"/stdlib.sh

: ${SFDX_BUILDPACK_DEBUG:="false"}

setup_dirs "."

eval $(parse_yaml sfdx.yml)

if [ "$STAGE" == "" ]; then
  echo "$(cat "$vendorDir"/reviewapp-release.txt)"
elif [ "$STAGE" == "DEV" ]; then
  echo "$(cat "$vendorDir"/dev-release.txt)"
else
  echo "$(cat "$vendorDir"/staging-release.txt)"
fi

exit 0