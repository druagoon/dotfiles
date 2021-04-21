#!/usr/bin/env python

import datetime
import time
import warnings

import clipboard


def main():
    ts = str(clipboard.paste())
    try:
        ts = float(ts)
    except:
        warnings.warn('Invalid timestamp. Use local current timestamp')
        ts = time.time()
    dt = datetime.datetime.fromtimestamp(ts)
    date = dt.strftime('%Y-%m-%d %H:%M:%S')
    print('{} -> {}'.format(ts, date))


if __name__ == '__main__':
    main()
