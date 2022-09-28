.PHONY: lint test beta-test

lint:
	shellcheck --version
	shellcheck *.sh

test:
	AUTIFY_CLI_INSTALLER_URL=https://autify-cli-assets.s3.amazonaws.com/autify-cli/channels/stable/install-cicd.bash bitrise run test

beta-test:
	AUTIFY_CLI_INSTALLER_URL=https://autify-cli-assets.s3.amazonaws.com/autify-cli/channels/beta/install-cicd.bash bitrise run test
