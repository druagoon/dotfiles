# -*- coding: utf-8 -*-

"""Output git status prompt compatible with Python2.7+
"""

import datetime
import functools
import os
import subprocess
import time

from compat import PY3, echo, ensure_text, is_true
if PY3:
    try:
        from typing import List, Tuple
    except:
        pass

DEBUG = is_true(os.environ.get('GIT_STATUS_DEBUG', False))
# change this symbol to whatever you prefer
PREFIX_HASH = os.environ.get('GIT_STATUS_PREFIX_HASH', ':')
HEAD = 'HEAD'
PREFIX_HEAD_REF = 'refs/heads/'
PREFIX_REMOTE_REF = 'refs/remotes/'
LOGFILE = os.path.expanduser('~/gitstatus.debug.log')
LOG_RESET = is_true(os.environ.get('GIT_STATUS_LOG_RESET', False))
INDENT = ' ' * 4


class FileStat(object):
    def __init__(self, changed=0, staged=0, conflicts=0, untracked=0, stashed=0):
        # type: (int, int, int, int, int) -> None
        self.changed = changed
        self.staged = staged
        self.conflicts = conflicts
        self.untracked = untracked
        self.stashed = stashed
        self.clean = 0 if self.total() > 0 else 1

    def total(self):
        # type () -> int
        nums = [
            self.changed,
            self.staged,
            self.conflicts,
            self.untracked,
            self.staged
        ]
        return sum(nums)


def truncate(filepath):
    # type: (str) -> None
    with open(filepath, 'w') as fp:
        pass


def debug(*args):
    # type: (Tuple) -> None
    if not DEBUG:
        return
    with open(LOGFILE, 'a') as fp:
        fp.write('\n'.join(map(str, args)) + '\n')


def timeit(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        now = datetime.datetime.now()
        debug(now.isoformat(' '))
        begin = time.time()
        rv = func(*args, **kwargs)
        end = time.time()
        debug('Total time: {}\n'.format(end - begin))
        return rv

    return wrapper


def run_shell(cmd, strip=True):
    # type: (str, bool) -> str

    output = ''
    try:
        output = subprocess.check_output(cmd, shell=True)
    except:
        pass
    output = ensure_text(output)
    if strip:
        output = output.strip()
    kwargs = {
        'cmd': cmd,
        'output': output,
        'indent': INDENT
    }
    debug('Cmd:\n{indent}{cmd}\nOutput:\n{indent}{output}'.format(**kwargs))
    return output


def get_git_dir():
    # type: () -> str
    return run_shell('git rev-parse --git-dir 2>/dev/null')


def is_git_repository():
    # type: () -> bool
    cmd = 'git rev-parse --is-inside-work-tree'
    rv = run_shell(cmd)
    out = rv.lower()
    return out == 'true'


def check_git_repository():
    # type: () -> bool
    root = get_git_dir()
    return bool(root)
    # return is_git_repository()


def get_commit_count():
    # type: () -> int
    cmd = 'git rev-list --all --count'
    rv = run_shell(cmd)
    return int(rv)


def get_abbrev_ref(ref):
    # type: (str) -> str
    return ref[len(PREFIX_HEAD_REF):]


def get_remote_ref(ref, remote='origin'):
    # type: (str, str) -> str
    kwargs = {
        'prefix_remote_ref': PREFIX_REMOTE_REF,
        'ref': ref,
        'remote': remote
    }
    return '{prefix_remote_ref}{remote}/{ref}'.format(**kwargs)


def check_head():
    # type: () -> str
    kwargs = {'head': HEAD}
    cmd = 'git symbolic-ref {head}'.format(**kwargs)
    rv = run_shell(cmd)
    return get_abbrev_ref(rv)


def get_changed_files():
    # type: () -> List[str]
    cmd = 'git diff --name-status'
    rv = run_shell(cmd)
    return [ns[0] for ns in rv.splitlines()]


def get_staged_files():
    # type: () -> List[str]
    cmd = 'git diff --name-status --staged'
    rv = run_shell(cmd)
    return [ns[0] for ns in rv.splitlines()]


def get_untracked_files_count():
    # type: () -> int
    cmd = 'git ls-files --exclude-standard --others | wc -l'
    rv = run_shell(cmd)
    return int(rv)


def get_stashed_count():
    # type: () -> int
    root = get_git_dir()
    stash_file = '{}{}'.format(root, '/logs/refs/stash')
    if not os.path.isfile(stash_file):
        return 0
    with open(stash_file) as fp:
        return len(fp.readlines())


def get_file_stat():
    # type: () -> FileStat
    changed_files = get_changed_files()
    n_changed = len(changed_files) - changed_files.count('U')
    staged_files = get_staged_files()
    n_conflicts = staged_files.count('U')
    n_staged = len(staged_files) - n_conflicts
    n_untracked = get_untracked_files_count()
    n_stashed = get_stashed_count()
    return FileStat(
        changed=n_changed,
        staged=n_staged,
        conflicts=n_conflicts,
        untracked=n_untracked,
        stashed=n_stashed
    )


def get_remote_repository_name(branch):
    # type: (str) -> str
    kwargs = {'branch': branch}
    cmd = 'git config branch.{branch}.remote'.format(**kwargs)
    return run_shell(cmd)


def get_merge_ref(branch):
    # type: (str) -> str
    kwargs = {'branch': branch}
    cmd = 'git config branch.{branch}.merge'.format(**kwargs)
    return run_shell(cmd)


def get_rev(target=None):
    # type: (str) -> str
    if not target:
        target = HEAD
    kwargs = {'target': target}
    cmd = 'git rev-parse --short {target}'.format(**kwargs)
    return run_shell(cmd)


def get_rev_list(left, right=None):
    # type: (str, str) -> List[str]
    if not right:
        right = HEAD
    kwargs = {'left': left, 'right': right}
    cmd = 'git rev-list --left-right {left}...{right}'.format(**kwargs)
    rv = run_shell(cmd)
    return rv.splitlines()


def get_ahead_behind(branch):
    # type: (str) -> Tuple[str, int, int]
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
        kwargs = {'prefix_hash': PREFIX_HASH, 'rev': rev}
        branch = '{prefix_hash}{rev}'.format(**kwargs)
    return branch, ahead, behind


def setup_log():
    if LOG_RESET:
        truncate(LOGFILE)


@timeit
def main():
    setup_log()
    if not check_git_repository():
        return
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
        stat.clean
    ]
    output = ' '.join(map(str, columns))
    echo(output, end='')


if __name__ == '__main__':
    main()
