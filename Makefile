.PHONY: \
	configure certs models action test doc release

.SILENT: \
	configure certs models action test doc release

configure:
	dart pub global activate pub_release
	dart pub global activate critical_test
	pub global activate dcli
	pub global activate dartdoc
	pub global activate dhttpd
	brew install act

certs:
	sh tool/gencert.sh . --secure

test:
	if [ ! -d test/certs ]; then . tool/gencert.sh test; fi
	dart test -j 1

models:
	echo "Generating models..."; \
	pub run build_runner build --delete-conflicting-outputs; \
	echo "[✓] Generating models complete."

doc:
	rm -rf doc
	dartdoc
	echo "Starting server at http://localhost:8080"
	dhttpd --path doc/api

action:
	echo "Running github actions..."
	act

release:
	echo 'Release to pub.dev...'
	pub_release --no-test
