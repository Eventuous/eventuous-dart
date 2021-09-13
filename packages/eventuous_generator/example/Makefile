.PHONY: \
	models test

.SILENT: \
	models test


test:
	dart test -j 1

models:
	echo "Generating models..."; \
	pub run build_runner build --delete-conflicting-outputs --verbose; \
	echo "[✓] Generating models complete."