.PHONY: \
	configure doc release

.SILENT: \
	configure doc release

configure:
	dart pub global activate pub_release
	dart pub global activate critical_test
	pub global activate dcli
	pub global activate dartdoc
	pub global activate dhttpd

doc:
	rm -rf doc
	dartdoc
	echo "Starting server at http://localhost:8080"
	dhttpd --path doc/api

release:
	echo 'Release to pub.dev...'
	pub_release --no-test