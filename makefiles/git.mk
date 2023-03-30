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

.PHONY: nb
nb:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) push $(GIT_REMOTE) --set-upstream $(cb)

.PHONY: push
push:
	$(GIT) push $(GIT_REMOTE)

.PHONY: push-%
push-%:
	$(GIT) push $(GIT_REMOTE) $(subst push-,,$@)

.PHONY: push!
push!:
	$(GIT) push $(GIT_REMOTE) --force-with-lease

.PHONY: pull
pull:
	$(GIT) pull $(GIT_REMOTE) --prune --rebase

.PHONY: pull-%
pull-%:
	$(eval name := $(subst pull-,,$@))
	$(GIT) checkout $(name) && $(MAKE) pull

.PHONY: pull!
pull!:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) fetch && \
	$(GIT) reset --hard $(GIT_REMOTE)/$(cb)

.PHONY: rebase-%
rebase-%:
	$(eval name := $(subst rebase-,,$@))
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) checkout $(name) && \
	$(GIT) pull $(GIT_REMOTE) --prune --rebase && \
	$(GIT) checkout $(cb) && \
	$(GIT) rebase $(name)

.PHONY: merge-%
merge-%:
	$(eval name := $(subst merge-,,$@))
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) checkout $(name) && \
	$(GIT) pull $(GIT_REMOTE) --prune --rebase && \
	$(GIT) checkout $(cb) && \
	$(GIT) merge --no-edit --no-ff $(name)
