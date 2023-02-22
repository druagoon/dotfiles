export LC_ALL=en_US.UTF-8

.DEFAULT_GOAL := motto
SHELL := /bin/bash

GIT := git
ROOT_DIR := $(shell cd `dirname "$0"`; pwd)
MOTTO := $(ROOT_DIR)/.motto

.PHONY: motto
motto:
	@if [ -f .motto ]; then cat .motto; fi

.PHONY: reset
reset:
	$(GIT) reset --hard HEAD

.PHONY: amend
amend:
	$(GIT) commit --amend --no-edit

.PHONY: nb
nb:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) push -u origin $(cb)

.PHONY: push
push:
	$(GIT) push origin

.PHONY: push!
push!:
	$(GIT) push origin --force-with-lease

.PHONY: fetch
fetch:
	$(GIT) fetch origin

.PHONY: pull
pull:
	$(GIT) pull origin --prune --rebase

.PHONY: pull!
pull!:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) fetch origin && \
	$(GIT) reset --hard origin/$(cb)

.PHONY: new
new:
	@if [ -z $(app) ]; then echo 'Error: missing `app` option'; \
	else mkdir -p $(app)/.oh-my-zsh/custom/{completions,slots}; fi
