export LC_ALL=en_US.UTF-8

.DEFAULT_GOAL := motto
SHELL := /bin/bash

MOTTO := $(ROOT_DIR)/.motto

.PHONY: motto
motto:
	@if [ -f .motto ]; then cat .motto; fi

.PHONY: new
new:
	@if [ -z $(app) ]; then echo 'Error: missing `app` option'; \
	else mkdir -p $(app)/.oh-my-zsh/custom/{completions,slots}; fi
