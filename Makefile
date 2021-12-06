.PHONY: motto

export LC_ALL=en_US.UTF-8
GIT=/usr/local/bin/git
TMP_DIR=$(HOME)/Temp
ROOT_DIR=$(shell cd `dirname "$0"`; pwd)
MOTTO=$(ROOT_DIR)/.motto

motto:
	@cat $(MOTTO)

reset:
	$(GIT) reset --hard HEAD

amend:
	$(GIT) commit --amend --no-edit

push:
	$(GIT) push origin

push!:
	$(GIT) push origin --force-with-lease

fetch:
	$(GIT) fetch origin

pull:
	$(GIT) pull origin --prune --rebase

pull!:
	$(GIT) fetch origin && $(GIT) reset --hard origin/`$(GIT) rev-parse --abbrev-ref HEAD`
