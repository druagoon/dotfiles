.DEFAULT_GOAL := help

SHELL := bash

# BASE_DIR := $(shell cd "`dirname "$0"`" >/dev/null 2>&1 && pwd)

##@ Lint && Format

fmt-yaml: ## Format YAML files using yamlfmt
	@yamlfmt .

##@ General

.PHONY: help
help: ## Display help messages
	@./.make/help "$(MAKEFILE_LIST)"
