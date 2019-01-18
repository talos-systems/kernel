TAG := $(shell gitmeta image tag)

TOOLCHAIN_VERSION ?= bfdccf2

export DOCKER_BUILDKIT := 1

all: enforce kernel

enforce:
	@docker run --rm -it -v $(PWD):/src -w /src autonomy/conform:latest

kernel:
	@docker build \
		-t autonomy/$@:$(TAG) \
		--target=$@ \
		-f ./Dockerfile \
		--build-arg TOOLCHAIN_VERSION=$(TOOLCHAIN_VERSION) \
		.
