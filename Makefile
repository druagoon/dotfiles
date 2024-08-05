.DEFAULT_GOAL := motto

SHELL := bash
SHFMT := shfmt -l -w -ln=auto -i 4 -ci -bn

BASE_DIR := $(shell cd `dirname "$0"`; pwd)
PKG_DIR := packages

.PHONY: motto
motto:
	@if [[ -f .motto ]]; then cat .motto; fi

.PHONY: init
init:
	@echo "Ruby bundle install ..."
	@bundle install

.PHONY: pkg
pkg:
	@if [[ -z "$(name)" ]]; then \
		echo 'Error: missing `name` option'; \
	else \
		mkdir -p "$(PKG_DIR)/$(name)"/{.zfunc,.zcomp}; \
		mkdir -p "$(PKG_DIR)/$(name)"/.oh-my-zsh/custom/{completions,slots}; \
	fi

.PHONY: brewfile
brewfile:
	cd "$(PKG_DIR)/brew" && brew bundle dump --describe --force

.PHONY: fmt-shell
fmt-shell:
	$(SHFMT) .

.PHONY: dotf
dotf:
	cd ./cli/dotf && $(MAKE) build
