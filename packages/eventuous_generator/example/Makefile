.PHONY: \
	models

.SILENT: \
	models

models:
	echo "Generating models..."; \
	mkdir  -p "lib/src/generated"; \
	protoc --dart_out="generate_kythe_info,grpc:lib/src/generated" \
		--proto_path protos \
		  google/protobuf/empty.proto \
		--proto_path lib/src; \
	dart format lib/src/generated
