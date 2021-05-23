#!/bin/bash
#
# Upload to Autify
set -eux

readonly API_BASE_ADDRESS="https://mobile-app.autify.com/api/v1"

info() {
  printf "$(tput setaf 7)- %s$(tput sgr0)\n" "$@"
}

success() {
  printf "$(tput setaf 64)✓ %s$(tput sgr0)\n" "$@"
}

error() {
  printf "$(tput setaf 1)x %s$(tput sgr0)\n" "$@"
}

main() {
  TOKEN_HEADER="Authorization: Bearer ${UPLOAD_TOKEN}"
  API_UPLOAD_ADDRESS="${API_BASE_ADDRESS}/projects/${PROJECT_ID}/builds"
  RESPONSE=$(curl -X POST "${API_UPLOAD_ADDRESS}" -H "accept: application/json" -H "${TOKEN_HEADER}" -H "Content-Type: multipart/form-data" -F "file=@${APP_DIR_PATH};type=application/zip" -w '\n%{http_code}' -s)

  # http status
  HTTP_STATUS=$(echo "$RESPONSE" | tail -n 1)
  # body
  BODY=$(echo "$RESPONSE" | sed '$d')

  if [[ "$HTTP_STATUS" != "201" ]]; then
    error "$BODY"
    exit 1
  fi

  success "$BODY"
}

main "$@"
