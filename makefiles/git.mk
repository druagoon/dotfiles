GIT := git

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
	$(GIT) push --set-upstream $(cb)

.PHONY: push
push:
	$(GIT) push

.PHONY: push-%
push-%:
	$(GIT) push $(subst push-,,$@)

.PHONY: push!
push!:
	$(GIT) push --force-with-lease

.PHONY: pull
pull:
	$(GIT) pull --prune --rebase

.PHONY: pull-%
pull-%:
	$(GIT) pull --prune --rebase $(subst pull-,,$@)

.PHONY: pull!
pull!:
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	@#$(eval rb := $(shell $(GIT) rev-parse --abbrev-ref --symbolic-full-name $(cb@{u}))
	$(GIT) fetch && \
	$(GIT) reset --hard origin/$(cb)
