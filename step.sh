#!/bin/bash
#
# Upload to Autify
set -e


export AUTIFY_UPLOAD_TOKEN="$upload_token"
export AUTIFY_PROJECT_ID="$project_id"
export AUTIFY_APP_DIR_PATH="$app_dir_path"
export AUTIFY_MOBILE_SCRIPT="https://raw.githubusercontent.com/autifyhq/autify-for-mobile-cli/main/autify_mobile_cli.sh"
export AUTIFY_MOBILE_SCRIPT_NAME="autify_mobile_cli.sh"

readonly API_BASE_ADDRESS="https://mobile-app.autify.com/api/v1"
readonly WORKIND_DIR="./"
readonly ZIP_NAME="upload.zip"

# download script
curl -L -o "./$AUTIFY_MOBILE_SCRIPT_NAME" $AUTIFY_MOBILE_SCRIPT
chmod 777 "./$AUTIFY_MOBILE_SCRIPT_NAME"

exec "./$AUTIFY_MOBILE_SCRIPT_NAME"
