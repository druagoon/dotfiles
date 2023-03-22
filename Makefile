export LC_ALL=en_US.UTF-8

.DEFAULT_GOAL := motto
SHELL := /bin/bash

.PHONY: motto
motto:
	@if [ -f .motto ]; then cat .motto; fi

# Generate new slot
.PHONY: slot
slot:
	@if [[ -z $(name) ]]; then \
		echo 'Error: missing `name` option'; \
	else \
		mkdir -p "$(name)"/.oh-my-zsh/custom/{completions,slots}; \
	fi

.PHONY: setup
setup:
	$(SHELL) ./setup.sh
