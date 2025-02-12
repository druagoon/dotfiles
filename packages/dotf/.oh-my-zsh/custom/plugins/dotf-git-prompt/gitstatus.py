# -*- coding: utf-8 -*-

"""Output git status for shell prompt."""

import functools
import logging
import os
import subprocess
import sys
import time
from typing import Optional

import six

DOTFILES_ROOT = os.environ.get("DOTFILES_ROOT", os.path.expanduser("~/.dotfiles"))
LOG_DIR = os.path.join(DOTFILES_ROOT, "logs")
LOG_FILE = os.path.join(LOG_DIR, "gitstatus.log")
DEBUG = os.environ.get("DOTF_GIT_STATUS_DEBUG", "0") == "1"

GIT_PREFIX_HASH = os.environ.get("DOTF_GIT_STATUS_PREFIX_HASH", ":")
GIT_HEAD = "HEAD"
GIT_PREFIX_HEAD_REF = "refs/heads/"
GIT_PREFIX_REMOTE_REF = "refs/remotes/"

logger = logging.getLogger(__name__)


class FileStat(object):
    def __init__(
        self,
        changed: int = 0,
        staged: int = 0,
        conflicts: int = 0,
        untracked: int = 0,
        stashed: int = 0,
    ) -> None:
        self.changed = changed
        self.staged = staged
        self.conflicts = conflicts
        self.untracked = untracked
        self.stashed = stashed
        self.clean = 0 if self.total() > 0 else 1

    def total(self) -> int:
        nums = [
            self.changed,
            self.staged,
            self.conflicts,
            self.untracked,
            self.staged,
        ]
        return sum(nums)


def echo(s: str, end: Optional[str] = None) -> None:
    if end is None:
        end = os.linesep
    sys.stdout.write(s + end)
    sys.stdout.flush()


def debug(*args: str) -> None:
    if not DEBUG:
        return
    with open(LOG_FILE, "a") as fp:
        fp.write("\n".join(map(str, args)) + "\n")


def timeit(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        begin = time.time()
        rv = func(*args, **kwargs)
        end = time.time()
        cost = end - begin
        logger.debug(f"{func.__name__=} => {cost=}")
        return rv

    return wrapper


def run_shell(cmd: str, strip: bool = True) -> str:
    output = ""
    try:
        output = subprocess.check_output(cmd, shell=True)
    except:  # noqa: E722
        pass
    output = six.ensure_text(output)
    if strip:
        output = output.strip()
    logger.debug(f"{cmd=} => {output=}")
    return output


def get_git_dir() -> str:
    return run_shell("git rev-parse --git-dir 2>/dev/null")


def is_git_repository() -> bool:
    cmd = "git rev-parse --is-inside-work-tree"
    rv = run_shell(cmd)
    out = rv.lower()
    return out == "true"


def check_git_repository() -> bool:
    root = get_git_dir()
    return bool(root)
    # return is_git_repository()


def get_commit_count() -> int:
    cmd = "git rev-list --all --count"
    rv = run_shell(cmd)
    return int(rv)


def get_abbrev_ref(ref: str) -> str:
    return ref[len(GIT_PREFIX_HEAD_REF) :]


def get_remote_ref(ref: str, remote: str = "origin") -> str:
    return f"{GIT_PREFIX_REMOTE_REF}{remote}/{ref}"


def check_head() -> str:
    cmd = f"git symbolic-ref {GIT_HEAD}"
    rv = run_shell(cmd)
    return get_abbrev_ref(rv)


def get_changed_files() -> list[str]:
    cmd = "git diff --name-status"
    rv = run_shell(cmd)
    return [ns[0] for ns in rv.splitlines()]


def get_staged_files() -> list[str]:
    cmd = "git diff --name-status --staged"
    rv = run_shell(cmd)
    return [ns[0] for ns in rv.splitlines()]


def get_untracked_files_count() -> int:
    cmd = "git ls-files --exclude-standard --others | wc -l"
    rv = run_shell(cmd)
    return int(rv)


def get_stashed_count() -> int:
    root = get_git_dir()
    stash_file = f"{root}/logs/refs/stash"
    if not os.path.isfile(stash_file):
        return 0
    with open(stash_file) as fp:
        return len(fp.readlines())


def get_file_stat() -> FileStat:
    changed_files = get_changed_files()
    n_changed = len(changed_files) - changed_files.count("U")
    staged_files = get_staged_files()
    n_conflicts = staged_files.count("U")
    n_staged = len(staged_files) - n_conflicts
    n_untracked = get_untracked_files_count()
    n_stashed = get_stashed_count()
    return FileStat(
        changed=n_changed,
        staged=n_staged,
        conflicts=n_conflicts,
        untracked=n_untracked,
        stashed=n_stashed,
    )


def get_remote_repository_name(branch: str) -> str:
    cmd = f"git config branch.{branch}.remote"
    return run_shell(cmd)


def get_merge_ref(branch: str) -> str:
    cmd = f"git config branch.{branch}.merge"
    return run_shell(cmd)


def get_rev(target: Optional[str] = None) -> str:
    if not target:
        target = GIT_HEAD
    cmd = f"git rev-parse --short {target}"
    return run_shell(cmd)


def get_rev_list(left: str, right: Optional[str] = None) -> list[str]:
    if not right:
        right = GIT_HEAD
    cmd = f"git rev-list --left-right {left}...{right}"
    rv = run_shell(cmd)
    return rv.splitlines()


def get_ahead_behind(branch: str) -> tuple[str, int, int]:
    ahead, behind = 0, 0
    if branch:
        remote_name = get_remote_repository_name(branch)
        if remote_name:
            merge_ref = get_merge_ref(branch)
            if remote_name == ".":
                remote_ref = merge_ref
            else:
                remote_ref = get_remote_ref(get_abbrev_ref(merge_ref), remote_name)
            rev_list = get_rev_list(remote_ref)
            if not rev_list:
                rev_list = get_rev_list(merge_ref)
            if rev_list:
                ahead = len([x for x in rev_list if x[0] == ">"])
                behind = len(rev_list) - ahead
    else:
        rev = get_rev()
        branch = f"{GIT_PREFIX_HASH}{rev}"
    return branch, ahead, behind


def setup_log() -> None:
    if not DEBUG:
        return
    if not os.path.isdir(LOG_DIR):
        os.makedirs(LOG_DIR, mode=0o755, exist_ok=True)
    logging.basicConfig(
        filename=LOG_FILE,
        encoding="utf-8",
        level=logging.DEBUG,
        format="[%(asctime)s] %(levelname)s %(name)s:%(funcName)s:%(lineno)d: %(message)s",
    )


def print_git_status() -> None:
    stat = get_file_stat()
    branch, ahead, behind = get_ahead_behind(check_head())
    columns = [
        branch,
        ahead,
        behind,
        stat.staged,
        stat.conflicts,
        stat.changed,
        stat.untracked,
        stat.stashed,
        stat.clean,
    ]
    output = " ".join(map(str, columns))
    echo(output, end="")


@timeit
def main():
    if not check_git_repository():
        return
    setup_log()
    print_git_status()


if __name__ == "__main__":
    main()
