#!/usr/bin/env python

"""MongoDB ObjectID 解析
"""

import collections
import datetime
from typing import List

import click

FORMAT = '%Y-%m-%d %H:%M:%S'


def parse_object_id(object_id: str) -> collections.OrderedDict:
    data = collections.OrderedDict()
    bits = [('ts', 8), ('machine', 6), ('pid', 4), ('inc', 6)]
    i = 0
    for k, v in bits:
        data[k] = object_id[i:i + v]
        i = v
    dt = datetime.datetime.fromtimestamp(int(data['ts'], 16))
    data['f_time'] = dt.strftime(FORMAT)
    return data


@click.command(help='MongoDB ObjectID 解析')
@click.option('-i', '--id', multiple=True, help='object id')
def main(id: List[str]):
    indent = ' ' * 4
    for v in id:
        result = list(parse_object_id(v).items())
        print(f'{v}:\n{indent}{result}')


if __name__ == '__main__':
    main()
