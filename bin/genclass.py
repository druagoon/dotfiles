#!/usr/bin/env python

"""类名生成(Pascal命名法)
"""

import re

import click
import clipboard


@click.command(help='类名转换')
@click.option('-k', '--key', help='原字符串')
def main(key: str):
    segment = re.split('[^A-Za-z0-9]+', key)
    parts = filter(None, [v.strip().title() for v in segment])
    name = ''.join(parts)
    clipboard.copy(name)
    print(f'{key} -> {name}')


if __name__ == '__main__':
    main()
