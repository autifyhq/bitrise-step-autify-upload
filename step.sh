#!/bin/bash
#
# Upload to Autify
set -eux

readonly API_BASE_ADDRESS="https://mobile-app.autify.com/api/v1"
readonly WORKIND_DIR="./"
readonly ZIP_NAME="upload.zip"

info() {
  printf "$(tput setaf 7)- %s$(tput sgr0)\n" "$@"
}

success() {
  printf "$(tput setaf 64)✓ %s$(tput sgr0)\n" "$@"
}

error() {
  printf "$(tput setaf 1)x %s$(tput sgr0)\n" "$@"
}

create_app_zip() {
  cp -r "${BITRISE_APP_DIR_PATH}" "${WORKIND_DIR}"

  APP_ZIP_PATH="./${ZIP_NAME}"
  APP_NAME=$(basename "${BITRISE_APP_DIR_PATH}")
  zip -r "${APP_ZIP_PATH}" "${APP_NAME}"
}

main() {
  create_app_zip

  TOKEN_HEADER="Authorization: Bearer ${UPLOAD_TOKEN}"
  API_UPLOAD_ADDRESS="${API_BASE_ADDRESS}/projects/${PROJECT_ID}/builds"
  RESPONSE=$(curl -X POST "${API_UPLOAD_ADDRESS}" -H "accept: application/json" -H "${TOKEN_HEADER}" -H "Content-Type: multipart/form-data" -F "file=@${APP_ZIP_PATH};type=application/zip" -w '\n%{http_code}' -s)

  # http status
  HTTP_STATUS=$(echo "$RESPONSE" | tail -n 1)
  # body
  BODY=$(echo "$RESPONSE" | sed '$d')
  # set env
  envman add --key "AUTIFY_UPLOAD_STEP_RESULT_JSON" --value "$BODY"

  if [[ "$HTTP_STATUS" != "201" ]]; then
    error "$BODY"
    exit 1
  fi

  success "$BODY"
}

main "$@"
