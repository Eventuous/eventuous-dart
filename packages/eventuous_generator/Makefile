.PHONY: \
	models test doc verify release

.SILENT: \
	models test doc verify release

test:
	dart test -j 1

models:
	echo "Generating models..."; \
	dart run build_runner build --verbose --delete-conflicting-outputs; \
	echo "[✓] Generating models complete."

doc:
	rm -rf doc
	dartdoc
	echo "Starting server at http://localhost:8080"
	dhttpd --path doc/api

verify:
	echo "Verifying package..."
	dart pub publish --dry-run

release:
	echo 'Release to pub.dev...'
	pub_release --no-test