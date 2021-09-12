.PHONY: \
	configure generate verify update action

.SILENT: \
	configure generate verify update action

configure:
	dart pub global activate mono_repo
	brew install act

generate:
	echo "Generating github actions for all packages..."
	mono_repo generate

verify:
	echo "Verifying packages..."
	mono_repo check
	mono_repo presubmit

upgrade:
	echo "Updating packages..."
	mono_repo pub upgrade --major-versions

action:
	echo "Running github actions..."
	act
