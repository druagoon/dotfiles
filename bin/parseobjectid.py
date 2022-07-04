#!/usr/bin/env python3

"""Parse mongodb object id
"""

import collections
import datetime
from typing import List

import click
from tabulate import tabulate

FORMAT = '%Y-%m-%d %H:%M:%S'


def parse_object_id(object_id: str) -> List:
    value = collections.OrderedDict()
    parts = [('ts', 8), ('machine', 6), ('pid', 4), ('inc', 6)]
    i = 0
    for k, v in parts:
        value[k] = object_id[i:i + v]
        i = v
    dt = datetime.datetime.fromtimestamp(int(value['ts'], 16))
    value['time_format'] = dt.strftime(FORMAT)
    data = [object_id, *value.values()]
    return data


@click.command(help='Parse mongodb object id')
@click.option('-i', '--id', multiple=True, help='object id')
def main(id: List[str]):
    indent = ' ' * 4
    headers = ['Oid', 'Timestamp', 'Machine', 'Pid', 'Inc', 'Timeformat']
    rows = []
    for v in id:
        rows.append(parse_object_id(v))
    output = tabulate(
        rows,
        headers=headers,
        tablefmt='grid',
        floatfmt='.2f',
        numalign='left',
        stralign='left'
    )
    print(output)


if __name__ == '__main__':
    main()
