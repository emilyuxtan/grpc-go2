.PHONY: generate


CLIENT_PROTO := helloworld/helloworld-client.proto
SERVER_PROTO := helloworld/helloworld-server.proto
GEN_DIR := ./helloworld
# DOCKER_IMAGE := namely/protoc-all:latest
DOCKER_IMAGE := bufbuild/buf:latest

generate-client:
	docker run --user=$$(id-u):$$(id -g) --rm \
 	-v "${PWD}":/defs \
 	-w /defs \
 	$(DOCKER_IMAGE) \
	generate \
	--path ${CLIENT_PROTO} \
	--output ${GEN_DIR} \
	--template buf.gen.client.yaml \
	--plugin buf.build/buf.gen.go.v1beta1.options={"with_gogo"} \
	--plugin buf.build/buf.gen.grpc.go.v1beta1.options={"require_unimplemented_servers=false"}

generate-server:
	docker run --user=$$(id-u):$$(id -g) --rm \
 	-v "${PWD}":/defs \
 	-w /defs \
 	$(DOCKER_IMAGE) \
	generate \
	--path ${SERVER_PROTO} \
	--output ${GEN_DIR} \
	--template buf.gen.server.yaml \
	--plugin buf.build/buf.gen.go.v1beta1.options={"with_gogo"}



# generate-client:
# 	docker run --user=$$(id -u):$$(id -g) --rm \
# 	-v "${PWD}/${CLIENT_PROTO}":/defs/helloworld-client.proto \
# 	-v "${PWD}/${GEN_DIR}":/output \
# 	-w /defs \
# 	$(DOCKER_IMAGE) \
# 	--lint --go-source-relative \
# 	-i /defs \
# 	-d /defs \
# 	-l go \
# 	-o /output \
# 	--go-grpc_out=/output \
# 	--go-grpc_opt=paths=source_relative, require_unimplemented_servers=false \
# 	/defs/helloworld-client.proto 
# 
# generate-server:
# 	docker run --user=$$(id -u):$$(id -g) --rm \
# 	-v "${PWD}/${SERVER_PROTO}":/defs/helloworld-server.proto \
# 	-v "${PWD}/${GEN_DIR}":/output \
# 	-w /defs \
# 	$(DOCKER_IMAGE) \
# 	--lint --go-source-relative \
# 	-i /defs \
# 	-d /defs \
# 	-l go \
# 	-o /output \
# 	--go_oua=/output \
# 	--go_opt=paths=source_relative \
# 	/defs/helloworld-server.proto


# generate:
# 	docker run --user=$$(id -u):$$(id -g) --rm \
# 	-v "${PWD}/${PROTO_DIR}":/defs \
# 	-v "${PWD}/${GEN_DIR}":/output \
# 	-w /defs \
# 	$(DOCKER_IMAGE) \
# 	--lint --go-source-relative \
# 	-i /defs \
# 	-d /defs \
# 	-l go \
# 	-o /output \
# 	--go_out=/output \
# 	--go_opt=paths=source_relative \
# 	--go-grpc_out=/output \
# 	--go-grpc_opt=paths=source_relative \
# 	${CLIENT_PROTO} \
# 	${SERVER_PROTO}
