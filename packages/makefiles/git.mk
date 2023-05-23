GIT ?= git
GIT_REMOTE ?= origin

# $(eval rb := $(shell $(GIT) rev-parse --abbrev-ref --symbolic-full-name $(cb@{u}))

.PHONY: reset
reset:
	$(GIT) reset --hard HEAD

.PHONY: amend
amend:
	$(GIT) commit --amend --no-edit

.PHONY: reuse
reuse:
	$(GIT) commit --reuse-message=HEAD

.PHONY: rbr
rbr:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) push $(GIT_REMOTE) --set-upstream $(cb)

.PHONY: push
push:
	$(GIT) push $(GIT_REMOTE)

.PHONY: pushf
pushf:
	$(GIT) push $(GIT_REMOTE) --force-with-lease

.PHONY: pull
pull:
	@if [[ -n "$(branch)" ]]; then $(GIT) checkout "$(branch)"; fi
	$(GIT) pull $(GIT_REMOTE) --prune --rebase

.PHONY: pullf
pullf:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) fetch && $(GIT) reset --hard $(GIT_REMOTE)/$(cb)

.PHONY: rebase
rebase:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) checkout $(branch) && \
	$(GIT) pull $(GIT_REMOTE) --prune --rebase && \
	$(GIT) checkout $(cb) && \
	$(GIT) rebase $(branch)

.PHONY: merge
merge:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) checkout $(branch) && \
	$(GIT) pull $(GIT_REMOTE) --prune --rebase && \
	$(GIT) checkout $(cb) && \
	$(GIT) merge --no-edit --no-ff $(branch)
