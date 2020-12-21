#!/bin/bash
#
# Upload to Autify
set -eux

readonly STEP_VERSION=0.0.0

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
  #
}

main "$@"
