GIT ?= git## Git execute command path
GIT_REMOTE ?= origin## Git remote repository alias

# $(eval rb := $(shell $(GIT) rev-parse --abbrev-ref --symbolic-full-name $(cb@{u}))

##@ Git

.PHONY: reset
reset: ## Git reset with `--hard HEAD` then discard local changes
	$(GIT) reset --hard HEAD

.PHONY: amend
amend: ## Git commit with --amend
	$(GIT) commit --amend --no-edit

.PHONY: reuse
reuse: ## Git commit with --reuse-message=HEAD
	$(GIT) commit --reuse-message=HEAD

.PHONY: psup
psup: ## Git push current branch to remote with `--set-upstream`
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) push $(GIT_REMOTE) --set-upstream $(cb)

.PHONY: push
push: ## Git push to remote
	$(GIT) push $(GIT_REMOTE)

.PHONY: pushf
pushf:  ## Git force push with `--force-with-lease`
	$(GIT) push $(GIT_REMOTE) --force-with-lease

.PHONY: pull
pull: ## Git pull with `--prune` and `--rebase`
	@if [[ -n "$(branch)" ]]; then $(GIT) checkout "$(branch)"; fi
	$(GIT) pull $(GIT_REMOTE) --prune --rebase

.PHONY: pullf
pullf: ## Fetch to the latest then use remote to override local branch
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) fetch && $(GIT) reset --hard $(GIT_REMOTE)/$(cb)

.PHONY: rebase
rebase: ## Pull the branch to the latest, then rebase it
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) checkout $(branch) && \
	$(GIT) pull $(GIT_REMOTE) --prune --rebase && \
	$(GIT) checkout $(cb) && \
	$(GIT) rebase $(branch)

.PHONY: merge
merge: ## Pull the branch to the latest, then merge it with `--no-ff`
	$(eval cb := $(shell $(GIT) rev-parse --abbrev-ref HEAD))
	$(GIT) checkout $(branch) && \
	$(GIT) pull $(GIT_REMOTE) --prune --rebase && \
	$(GIT) checkout $(cb) && \
	$(GIT) merge --no-edit --no-ff $(branch)
