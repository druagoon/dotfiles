#!/usr/bin/env python

"""Convert Class Name to Pascal
"""

import re

import click
import clipboard


@click.command(help='Convert Class Name to Pascal')
@click.option('-n', '--name', help='source name')
def main(name: str):
    segment = re.split('[^A-Za-z0-9]+', name)
    parts = filter(None, [v.strip().title() for v in segment])
    rv = ''.join(parts)
    clipboard.copy(rv)
    print(f'{name} -> {rv}')


if __name__ == '__main__':
    main()
