SHELL := bash

.DEFAULT_GOAL := motto

SHFMT := shfmt -ln=auto -i 4 -ci -bn -w

BASE_DIR := $(shell cd `dirname "$0"`; pwd)
PKG_DIR := ./packages

DOTF := dotf
DOTF_TARGET := $(HOME)/.local/bin/$(DOTF)
DOTF_COMPLETION = $(PKG_DIR)/dotf/.oh-my-zsh/custom/completions/_dotf.zsh

.PHONY: motto
motto:
	@if [[ -f .motto ]]; then cat .motto; fi

.PHONY: init
init:
	brew list ruby &>/dev/null || brew install ruby
	$(eval ruby_root := $(shell brew --prefix ruby))
	@echo "Ruby bundle install ..."
	@$(ruby_root)/bin/bundle install

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

.PHONY: fmtall
fmtall: fmt fmtpkg

.PHONY: fmtpkg
fmtpkg:
	$(SHFMT) $(PKG_DIR)

.PHONY: fmt
fmt:
	$(SHFMT) src $(DOTF)

.PHONY: link
link:
	ln -sfv "$(BASE_DIR)/$(DOTF)" "$(DOTF_TARGET)"

.PHONY: comp
comp:
	rm -f "$(DOTF_COMPLETION)" \
	&& bashly add completions_script "$(DOTF_COMPLETION)" \
	&& $(SHFMT) "$(DOTF_COMPLETION)"

.PHONY: dotf
dotf:
	bashly generate \
	&& $(MAKE) comp \
	&& $(MAKE) fmt \
	&& $(MAKE) link

.PHONY: clean
clean:
	rm -f "$(DOTF_TARGET)"
