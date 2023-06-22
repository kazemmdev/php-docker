# Image URL to use for all building/pushing image targets
REGISTRY ?= k90mirzaei/php

# List of supported PHP versions
PHP_VERSIONS := 8.1 8.2

# Dockerfile directory
DOCKERFILE_DIR ?= .

# Default build arguments
BUILD_ARGS ?=

# Default push arguments
PUSH_ARGS ?=

# Build all images
build: $(foreach version,$(PHP_VERSIONS),build-$(version))

# Build a specific image
build-%:
	@echo "Building PHP $*..."
	docker build $(DOCKERFILE_DIR)/fpm-alpine/$* -t $(REGISTRY):$*-fpm-alpine3.18 $(BUILD_ARGS)

# Push all images
push: $(foreach version,$(PHP_VERSIONS),push-$(version))

# Push a specific image
push-%:
	@echo "Pushing PHP $*..."
	docker push $(REGISTRY):$*-fpm-alpine3.18 $(PUSH_ARGS)

# Show makefile helper
help:
	@echo "Makefile available commands:"
	@echo ""
	@awk '/^[^\.%]/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			command = substr($$1, 1, index($$1, ":")-1); \
			printf "  \033[36m%-20s\033[0m %s\n", command, substr(lastLine, RSTART + 3, RLENGTH) \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@echo ""
	@echo "Passing arguments:"
	@echo "make build BUILD_ARGS=\"--no-cache\""
	@echo "make push PUSH_ARGS=\"--quiet\""

.DEFAULT_GOAL := help
.PHONY: help build push $(foreach version,$(PHP_VERSIONS),build-$(version)) $(foreach version,$(PHP_VERSIONS),push-$(version))