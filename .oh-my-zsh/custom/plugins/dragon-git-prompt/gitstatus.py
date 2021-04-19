#!/usr/bin/env python
from __future__ import print_function

import os
import subprocess
import sys
from dataclasses import dataclass
from typing import List, Tuple

DEBUG = False
# change this symbol to whatever you prefer
PREFIX_HASH = ':'
HEAD = 'HEAD'
PREFIX_HEAD_REF = 'refs/heads/'
PREFIX_REMOTE_REF = 'refs/remotes/'
LOGFILE = os.path.expanduser('~/gitstatus.debug.log')
LOG_RESET = False


@dataclass
class FileStat:
    changed: int = 0
    staged: int = 0
    conflicts: int = 0
    untracked: int = 0


def debug(*args):
    global LOG_RESET

    if not DEBUG:
        return
    if not LOG_RESET:
        open(LOGFILE, 'w').close()
        LOG_RESET = True
    with open(LOGFILE, 'a') as fp:
        fp.write('\n'.join(map(str, args)) + '\n')


def run(cmd: str, **kwargs) -> subprocess.CompletedProcess:
    kwargs.setdefault('shell', True)
    kwargs.setdefault('capture_output', True)
    kwargs.setdefault('text', True)
    debug(cmd)
    return subprocess.run(cmd, **kwargs)


def check_git_repository():
    cp = run('git rev-parse --is-inside-work-tree')
    result = cp.stdout.strip().lower()
    if result != 'true':
        sys.exit(0)


def get_commit_count():
    cp = run('git rev-list --all --count')
    return int(cp.stdout.strip())


def get_abbrev_ref(ref: str) -> str:
    return ref[len(PREFIX_HEAD_REF):]


def get_remote_ref(ref: str, remote: str = 'origin') -> str:
    return f'{PREFIX_REMOTE_REF}{remote}/{ref}'


def check_head():
    cp = run(f'git symbolic-ref {HEAD}')
    out = cp.stdout.strip()
    return get_abbrev_ref(out)


def get_changed_files() -> List[str]:
    cp = run('git diff --name-status')
    out = cp.stdout.strip()
    return [ns[0] for ns in out.splitlines()]


def get_staged_files() -> List[str]:
    cp = run('git diff --name-status --staged')
    out = cp.stdout.strip()
    return [ns[0] for ns in out.splitlines()]


def get_untracked_files_count() -> int:
    cp = run('git ls-files --exclude-standard --others|wc -l')
    return int(cp.stdout.strip())


def get_file_stat() -> FileStat:
    changed_files = get_changed_files()
    n_changed = len(changed_files) - changed_files.count('U')
    staged_files = get_staged_files()
    n_conflicts = staged_files.count('U')
    n_staged = len(staged_files) - n_conflicts
    n_untracked = get_untracked_files_count()
    return FileStat(changed=n_changed, staged=n_staged, conflicts=n_conflicts, untracked=n_untracked)


def get_remote_repository_name(branch: str) -> str:
    cp = run(f'git config branch.{branch}.remote')
    return cp.stdout.strip()


def get_merge_ref(branch: str) -> str:
    cp = run(f'git config branch.{branch}.merge')
    return cp.stdout.strip()


def get_rev(target: str = HEAD) -> str:
    cp = run(f'git rev-parse --short {target}')
    return cp.stdout.strip()


def get_rev_list(left: str, right: str = HEAD) -> List[str]:
    cp = run(f'git rev-list --left-right {left}...{right}')
    out = cp.stdout.strip()
    return out.splitlines()


def get_ahead_behind(branch: str) -> Tuple[str, int, int]:
    ahead, behind = 0, 0
    if branch:
        remote_name = get_remote_repository_name(branch)
        if remote_name:
            merge_ref = get_merge_ref(branch)
            if remote_name == '.':
                remote_ref = merge_ref
            else:
                remote_ref = get_remote_ref(get_abbrev_ref(merge_ref), remote_name)
            rev_list = get_rev_list(remote_ref)
            if not rev_list:
                rev_list = get_rev_list(merge_ref)
            if rev_list:
                ahead = len([x for x in rev_list if x[0] == '>'])
                behind = len(rev_list) - ahead
    else:
        rev = get_rev()
        branch = f'{PREFIX_HASH}{rev}'
    return branch, ahead, behind


def main():
    check_git_repository()
    stat = get_file_stat()
    branch, ahead, behind = get_ahead_behind(check_head())
    columns = [
        branch,
        ahead,
        behind,
        stat.staged,
        stat.conflicts,
        stat.changed,
        stat.untracked
    ]
    output = ' '.join(map(str, columns))
    print(output, end='')


main()
