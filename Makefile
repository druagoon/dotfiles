.DEFAULT_GOAL := help

SHELL := bash
SHFMT := shfmt -l -w -ln=auto -i 4 -ci -bn

BASE_DIR := $(shell cd `dirname "$0"`; pwd)
PKG_DIR := packages

##@ Project

.PHONY: motto
motto: ## Show motto
	@if [[ -f .motto ]]; then cat .motto; fi

.PHONY: init-ruby
init-ruby: ## Initialize ruby bundle
	@echo "Ruby bundle install ..."
	@bundle install

##@ Package

.PHONY: pkg
pkg: ## Generate package's layout
	@if [[ -z "$(name)" ]]; then \
		echo 'Error: missing `name` option'; \
	else \
		mkdir -p "$(PKG_DIR)/$(name)"/{.zfunc,.zcomp}; \
		mkdir -p "$(PKG_DIR)/$(name)"/.oh-my-zsh/custom/{completions,slots}; \
	fi

##@ Brew

.PHONY: brewfile
brewfile: ## Generate brewfile by `brew bundle dump` command
	cd "$(PKG_DIR)/brew" && brew bundle dump --describe --force

##@ Lint & Format

.PHONY: fmt-shell
fmt-shell: ## Format shell scripts by `shfmt`
	$(SHFMT) .

##@ Dotfiles cli

.PHONY: dotf
dotf: ## Build `dotf` cli
	cd ./cli/dotf && $(MAKE) build

##@ General

.PHONY: help
help: ## Display help messages
	@./.make/help "$(MAKEFILE_LIST)"
