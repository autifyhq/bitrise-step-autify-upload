#!/bin/bash
set -ex

ARGS=()

function add_args() {
  ARGS+=("$1")
}

function exit_script() {
  local code=$?
  envman add --key AUTIFY_UPLOAD_EXIT_CODE --value "${code}"
}
trap exit_script EXIT

# Install Autify CLI
curl https://autify-cli-assets.s3.amazonaws.com/autify-cli/channels/stable/install-cicd.bash | bash -xe
export PATH="$PWD/autify/bin:$PATH"
export XDG_CACHE_HOME="$PWD/.cache"
export XDG_CONFIG_HOME="$PWD/.config"
export XDG_DATA_HOME="$PWD/.data"

# Setup autify path
AUTIFY=${autify_path:-"autify"}

# Check access token
if [ -z "${access_token}" ]; then
  echo "Missing access-token."
  exit 1
fi

# Setup command line arguments
if [ -n "${build_path}" ]; then
  add_args "${build_path}"
else
  echo "Missing build_path."
  exit 1
fi

if [ -n "${workspace_id}" ]; then
  add_args "--workspace-id=${workspace_id}"
else
  echo "Missing workspace_id."
  exit 1
fi

# Execute a command
OUTPUT=./output.log
AUTIFY_MOBILE_ACCESS_TOKEN=${access_token} $AUTIFY mobile build upload "${ARGS[@]}" 2>&1 | tee $OUTPUT
exit_code=${PIPESTATUS[0]}

# Setup outputs
uploaded_build_id=$(grep "Successfully uploaded" "$OUTPUT" | grep -Eo 'ID: [^\)]+' | cut -f2 -d' ' | head -1)
envman add --key AUTIFY_BUILD_ID --value "${uploaded_build_id}"

# Exit
exit "$exit_code"
