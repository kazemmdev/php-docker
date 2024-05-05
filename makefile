# Image URL to use all building/pushing image targets
REGISTRY ?= k90mirzaei/php
VERSION  ?= 8.2.18-fpm-alpine3.19

all: build push

build: ## Build all images
	- @echo "Building..."
	- docker build ./fpm-alpine/8.1 -t $(REGISTRY):$(VERSION)
	- docker build ./fpm-alpine/8.2 -t $(REGISTRY):$(VERSION)

push: ## Push all images to github repo
	- @echo "Pushing..."
	- docker push $(REGISTRY):$(VERSION)
	- docker push $(REGISTRY):$(VERSION)


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
