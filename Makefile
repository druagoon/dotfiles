SHELL := /bin/bash

.DEFAULT_GOAL := motto

.PHONY: motto
motto:
	@if [ -f .motto ]; then cat .motto; fi

.PHONY: slot
slot:
	@if [[ -z "$(name)" ]]; then \
		echo 'Error: missing `name` option'; \
	else \
		mkdir -p "$(name)"/.oh-my-zsh/custom/{completions,slots}; \
	fi

.PHONY: brewfile
brewfile:
	brew bundle dump --describe --force
