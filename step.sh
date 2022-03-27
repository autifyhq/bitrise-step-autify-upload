#!/bin/bash
#
# Upload to Autify
set -e


export AUTIFY_UPLOAD_TOKEN="$upload_token"
export AUTIFY_PROJECT_ID="$project_id"
export AUTIFY_APP_DIR_PATH="$app_dir_path"
export AUTIFY_GITHUB_ORG="autifyhq"

# test for mobile cli
export AUTIFY_MOBILE_SCRIPT_BRANCH="$mobile_script_branch_name"
if [ -z "$AUTIFY_MOBILE_SCRIPT_BRANCH" ]; then
  AUTIFY_MOBILE_SCRIPT_BRANCH="develop"
fi
if [[ "$AUTIFY_MOBILE_SCRIPT_BRANCH" =~ ":" ]]; then
  ORG=(${AUTIFY_MOBILE_SCRIPT_BRANCH//:/ })
  AUTIFY_GITHUB_ORG=${ORG[0]}
  AUTIFY_MOBILE_SCRIPT_BRANCH=${ORG[1]}
fi

export AUTIFY_MOBILE_SCRIPT="https://raw.githubusercontent.com/${AUTIFY_GITHUB_ORG}/autify-for-mobile-cli/${AUTIFY_MOBILE_SCRIPT_BRANCH}/autify_mobile_cli.sh"
export AUTIFY_MOBILE_SCRIPT_NAME="autify_mobile_cli.sh"

readonly API_BASE_ADDRESS="https://mobile-app.autify.com/api/v1"
readonly WORKIND_DIR="./"
readonly ZIP_NAME="upload.zip"

# for develop
echo "develop parameters:"
echo "* mobile_script_branch_name: ${AUTIFY_MOBILE_SCRIPT_BRANCH}"

# download script
curl -L -o "$WORKIND_DIR/$AUTIFY_MOBILE_SCRIPT_NAME" $AUTIFY_MOBILE_SCRIPT
chmod 777 "$WORKIND_DIR/$AUTIFY_MOBILE_SCRIPT_NAME"

exec "$WORKIND_DIR/$AUTIFY_MOBILE_SCRIPT_NAME"
