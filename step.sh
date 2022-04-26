#!/bin/bash
#
# Upload to Autify
set -e

# shellcheck disable=SC2154
export AUTIFY_UPLOAD_TOKEN="$upload_token"
# shellcheck disable=SC2154
export AUTIFY_PROJECT_ID="$project_id"
# shellcheck disable=SC2154
export AUTIFY_APP_DIR_PATH="$app_dir_path"

export AUTIFY_MOBILE_SCRIPT="https://raw.githubusercontent.com/autifyhq/autify-for-mobile-cli/main/autify_mobile_cli.sh"
export AUTIFY_MOBILE_SCRIPT_NAME="autify_mobile_cli.sh"

readonly WORKIND_DIR="./"

# download script
curl -L -o "$WORKIND_DIR/$AUTIFY_MOBILE_SCRIPT_NAME" $AUTIFY_MOBILE_SCRIPT
chmod 777 "$WORKIND_DIR/$AUTIFY_MOBILE_SCRIPT_NAME"

exec "$WORKIND_DIR/$AUTIFY_MOBILE_SCRIPT_NAME"
