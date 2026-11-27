.DEFAULT_GOAL := help

SHELL := bash

# BASE_DIR := $(shell cd "`dirname "$0"`" >/dev/null 2>&1 && pwd)

##@ Lint && Format

.PHONY: fmt
fmt: fmt-markdown fmt-toml fmt-yaml ## Format all files

.PHONY: fmt-markdown
fmt-markdown: ## Format Markdown files
	autocorrect --fix **/*.md \
	&& rumdl check --fix \
	&& rumdl fmt

.PHONY: fmt-toml
fmt-toml: ## Format TOML files
	taplo fmt

.PHONY: fmt-yaml
fmt-yaml: ## Format YAML files
	ryl format .

##@ General

.PHONY: help
help: ## Display help messages
	@./.make/help "$(MAKEFILE_LIST)"
