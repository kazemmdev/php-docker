# Image URL to use all building/pushing image targets
REGISTRY ?= k90mirzaei/php
VERSION  ?= latest

all: build push

build: ## Build all images
	- @echo "Building..."
	- @for dir in $(shell find ./fpm-alpine -mindepth 1 -maxdepth 1 -type d); do \
		version=$$(basename $$dir); \
		echo "Building image for version $$version..."; \
		docker build $$dir -t $(REGISTRY):$$version-$(VERSION); \
	done

push: ## Push all images to github repo
	- @echo "Pushing..."
	- @for dir in $(shell find ./fpm-alpine -mindepth 1 -maxdepth 1 -type d); do \
		version=$$(basename $$dir); \
		echo "Pushing image for version $$version..."; \
		docker push $(REGISTRY):$$version-$(VERSION); \
	done


help: ## Show makefile helper
	- @printf '\e[1;33m%-6s\e[m' "Makefile available commands"
	- @echo ''
	- @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	- @echo -e '\n'
	- @printf '\e[1;33m%-6s\e[m' "Passing arguments"
	- @echo -e '\nmake image-dev ARGS="--no-cache"'
	- @echo -e '\nenvironment: \n $(ENV)'

.DEFAULT_GOAL := help
.PHONY: help
