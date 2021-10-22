.PHONY: \
	certs models test doc release

.SILENT: \
	certs models test doc release

certs:
	esdbtcli certs test

test:
	if [ ! -d test/certs ]; then esdbtcli certs test; fi
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