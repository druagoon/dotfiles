SHELL := bash

SHFMT := shfmt -ln=auto -i 4 -ci -bn -w
BASE_DIR := $(shell cd `dirname "$0"`; pwd)
DOTFILES_ROOT ?= $(HOME)/.dotfiles
PKG_DIR := $(DOTFILES_ROOT)/packages

EXEC := dotf
TARGET := $(HOME)/.local/bin/$(EXEC)
EXEC_COMPLETION = $(PKG_DIR)/dotf/.oh-my-zsh/custom/completions/_$(EXEC).zsh

.PHONY: generate
generate:
	bashly generate

.PHONY: comp
comp:
	rm -f "$(EXEC_COMPLETION)" \
	&& bashly add completions_script "$(EXEC_COMPLETION)"

.PHONY: fmt
fmt:
	$(SHFMT) src $(EXEC) $(EXEC_COMPLETION)

.PHONY: link
link:
	ln -sfv "$(BASE_DIR)/$(EXEC)" "$(TARGET)"

.PHONY: build
build: generate comp fmt link

.PHONY: clean
clean:
	rm -f "$(TARGET)"
