#!/usr/bin/env python

"""MongoDB ObjectID 生成(日期/时间戳)
"""

import datetime
import time
from typing import Optional

import click

FORMATS = [
    '%Y-%m-%d %H:%M:%S',
    '%Y-%m-%d'
]
OBJECT_ID_LEN = 24


def str2time(date_string: str) -> Optional[int]:
    for fmt in FORMATS:
        try:
            dt = datetime.datetime.strptime(date_string, fmt)
            return int(dt.timestamp())
        except:
            pass
    try:
        return int(float(date_string))
    except:
        pass


def gen_object_id(text: str) -> str:
    ts = str2time(text)
    ts_hex = f'{ts:08x}'
    padding = '0' * (OBJECT_ID_LEN - len(ts_hex))
    return f'ObjectId("{ts_hex}{padding}")'


@click.command(help='按照日期时间生成 MongoDB ObjectID')
@click.option('-t', '--text', default=None, help='datetime or timestamp string')
def main(text: str):
    if not text:
        text = str(int(time.time()))
    print(gen_object_id(text))


if __name__ == '__main__':
    main()
