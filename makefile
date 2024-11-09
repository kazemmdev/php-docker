# Image URL to use all building/pushing image targets
REGISTRY ?= k90mirzaei/php
VERSION  ?= latest

CHANGED_DIRS = $(shell git diff --name-only HEAD~1 HEAD | grep '^fpm-alpine/' | cut -d '/' -f 2 | sort | uniq)

all: build push

build: ## Build only changed images
	- @echo "Building..."
	- @for dir in $(CHANGED_DIRS); do \
		if [ -d ./fpm-alpine/$$dir ]; then \
			echo "Building image for version $$dir..."; \
			docker build ./fpm-alpine/$$dir -t $(REGISTRY):$$dir-$(VERSION); \
		fi \
	done

push: ## Push only changed images to GitHub repo
	- @echo "Pushing..."
	- @for dir in $(CHANGED_DIRS); do \
		if [ -d ./fpm-alpine/$$dir ]; then \
			echo "Pushing image for version $$dir..."; \
			docker push $(REGISTRY):$$dir-$(VERSION); \
		fi \
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
