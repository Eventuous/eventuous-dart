.PHONY: \
	configure generate test verify update action

.SILENT: \
	configure generate test verify update action

configure:
	dart pub global activate pub_release
	dart pub global activate critical_test
	dart pub global activate dcli
	dart pub global activate dartdoc
	dart pub global activate dhttpd
	dart pub global activate mono_repo
	dart pub global activate eventstore_client_test
	brew install act
	brew install protobuf
	brew install watch
	brew install docker
	brew install colima

	colima start

generate:
	echo "Generating github actions for all packages..."
	mono_repo generate

test:
	echo "Test packages..."
	cd packages/eventuous && dart test -j 1
	cd packages/eventuous_generator && dart test

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
