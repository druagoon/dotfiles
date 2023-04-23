SHELL := /bin/bash

.DEFAULT_GOAL := motto

PKG_DIR=packages

.PHONY: motto
motto:
	@if [[ -f .motto ]]; then cat .motto; fi

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

.PHONY: shellfmt
shellfmt:
	shfmt -ln=auto -i 4 -ci -bn -w .
