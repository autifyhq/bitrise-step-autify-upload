#!/bin/bash
#
# Upload to Autify
set -e

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
  cp -r "${app_dir_path}" "${WORKIND_DIR}"

  APP_ZIP_PATH="./${ZIP_NAME}"
  APP_NAME=$(basename "${app_dir_path}")
  zip -r "${APP_ZIP_PATH}" "${APP_NAME}"
}

main() {
  create_app_zip

  TOKEN_HEADER="Authorization: Bearer ${upload_token}"
  API_UPLOAD_ADDRESS="${API_BASE_ADDRESS}/projects/${project_id}/builds"
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

# parameters
info "parameters:"
info "* upload_token: ${upload_token}"
info "* project_id: ${project_id}"
info "* app_dir_path: ${app_dir_path}"

# run
main "$@"
