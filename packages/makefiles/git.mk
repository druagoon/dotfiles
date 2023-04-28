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
	$(eval name := $(subst push-,,$@))
	$(eval br := $(subst @,/,$(name)))
	$(GIT) push $(GIT_REMOTE) $(br)

.PHONY: pushf
pushf:
	$(GIT) push $(GIT_REMOTE) --force-with-lease

.PHONY: pull
pull:
	$(GIT) pull $(GIT_REMOTE) --prune --rebase

.PHONY: pull-%
pull-%:
	$(eval name := $(subst pull-,,$@))
	$(eval br := $(subst @,/,$(name)))
	$(GIT) checkout $(br) && $(MAKE) pull

.PHONY: pullf
pullf:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) fetch && \
	$(GIT) reset --hard $(GIT_REMOTE)/$(cb)

.PHONY: rebase-%
rebase-%:
	$(eval name := $(subst rebase-,,$@))
	$(eval br := $(subst @,/,$(name)))
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) checkout $(br) && \
	$(GIT) pull $(GIT_REMOTE) --prune --rebase && \
	$(GIT) checkout $(cb) && \
	$(GIT) rebase $(br)

.PHONY: merge-%
merge-%:
	$(eval name := $(subst merge-,,$@))
	$(eval br := $(subst @,/,$(name)))
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) checkout $(br) && \
	$(GIT) pull $(GIT_REMOTE) --prune --rebase && \
	$(GIT) checkout $(cb) && \
	$(GIT) merge --no-edit --no-ff $(br)
