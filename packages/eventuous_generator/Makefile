.PHONY: \
	configure models test doc release

.SILENT: \
	configure models test doc release

configure:
	dart pub global activate pub_release
	dart pub global activate critical_test
	pub global activate dcli
	pub global activate dartdoc
	pub global activate dhttpd

test:
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

release:
	echo 'Release to pub.dev...'
	pub_release --no-test