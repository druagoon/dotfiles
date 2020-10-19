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

push:
	$(GIT) push origin

forcepush:
	$(GIT) push origin --force-with-lease

update:
	$(GIT) pull origin --prune --rebase

forceupdate:
	$(GIT) fetch origin && $(GIT) reset --hard origin/`$(GIT) rev-parse --abbrev-ref HEAD`
