export LC_ALL=en_US.UTF-8

.DEFAULT_GOAL := motto
SHELL := /bin/bash

.PHONY: motto
motto:
	@if [ -f .motto ]; then cat .motto; fi

.PHONY: new
new:
	@if [ -z $(app) ]; then \
		echo 'Error: missing `app` option'; \
	else \
		mkdir -p $(app)/.oh-my-zsh/custom/{completions,slots}; \
	fi

.PHONY: init
init:
	$(SHELL) ./init.sh

.PHONY: install
	$(SHELL) ./install.sh
