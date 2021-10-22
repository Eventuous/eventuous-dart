.PHONY: \
	configure generate verify update action

.SILENT: \
	configure generate verify update action

configure:
	dart pub global activate pub_release
	dart pub global activate critical_test
	pub global activate dcli
	pub global activate dartdoc
	pub global activate dhttpd
	dart pub global activate mono_repo
	brew install act

generate:
	echo "Generating github actions for all packages..."
	mono_repo generate

verify:
	echo "Verifying packages..."
	mono_repo check
	mono_repo presubmit
	cd packages/eventuous && dart pub publish --dry-run
	cd packages/eventuous_test && dart pub publish --dry-run
	cd packages/eventuous_generator && dart pub publish --dry-run

upgrade:
	echo "Updating packages..."
	mono_repo pub upgrade --major-versions

action:
	echo "Running github actions..."
	act

release:
	echo 'Release all to pub.dev...'
	cd packages/eventuous && pub_release multi --no-test
