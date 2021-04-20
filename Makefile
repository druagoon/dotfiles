.PHONY: motto

export LC_ALL=en_US.UTF-8
GIT=/usr/local/bin/git
TMP_DIR=$(HOME)/Temp
APP_DIR=$(shell cd `dirname "$0"`; pwd)
MOTTO=$(APP_DIR)/.motto

motto:
	@cat $(MOTTO)

reset:
	$(GIT) reset --hard HEAD

amend:
	$(GIT) commit --amend --no-edit

push:
	$(GIT) push origin

force-push:
	$(GIT) push origin --force-with-lease

update:
	$(GIT) pull origin --prune --rebase

force-pull:
	$(GIT) fetch origin && $(GIT) reset --hard origin/`$(GIT) rev-parse --abbrev-ref HEAD`
