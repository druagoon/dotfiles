#!/usr/bin/env python3

"""Parse timestamp to RFC 3339
"""

import datetime
import time

import click
import clipboard
from tabulate import tabulate


@click.command('time2str', help=__doc__)
def main():
    ts = str(clipboard.paste())
    try:
        ts = float(ts)
    except:
        ts = time.time()
    dt = datetime.datetime.fromtimestamp(ts)
    formats = ['%Y-%m-%d %H:%M:%S', '%Y%m%d%H%M%S', '%Y%m%d_%H%M%S']
    dates = map(lambda x: dt.strftime(x), formats)
    headers = ['Timestamp', 'F1', 'F2', 'F3']
    rows = [[ts, *dates]]
    output = tabulate(
        rows,
        headers=headers,
        tablefmt='grid',
        floatfmt='.6f',
        numalign='left',
        stralign='left'
    )
    print(output)


if __name__ == '__main__':
    main()
